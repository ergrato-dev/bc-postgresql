#!/bin/zsh
# ============================================
# Autocommit Script - Bootcamp PostgreSQL
# ============================================
# What?    Automatic commit script using Conventional Commits format
# For?     Keep track of changes every 5 minutes via cron
# Impact?  Ensures no work is lost and maintains a clean git history
# ============================================

# --- Configuration ---
# What?    Define the repository path
# For?     Allow the script to work from any location (cron)
# Impact?  Script can run independently without cd issues
REPO_PATH="/home/epti/Documents/epti-dev/bc-channel/bc-postgresql"

# What?    Define log file path
# For?     Track script execution and debug issues
# Impact?  Easy troubleshooting if autocommit fails
LOG_FILE="${REPO_PATH}/_scripts/autocommit.log"

# What?    Maximum log file size in bytes (100KB)
# For?     Prevent log file from growing indefinitely
# Impact?  Disk space management
MAX_LOG_SIZE=102400

# --- Functions ---

# What?    Log messages with timestamp
# For?     Debugging and monitoring script execution
# Impact?  Clear audit trail of all autocommit actions
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] ${message}" >> "${LOG_FILE}"
}

# What?    Rotate log file if too large
# For?     Prevent disk space issues
# Impact?  Keeps only recent logs, removes old ones
rotate_log() {
    if [[ -f "${LOG_FILE}" ]] && [[ $(stat -f%z "${LOG_FILE}" 2>/dev/null || stat -c%s "${LOG_FILE}" 2>/dev/null) -gt ${MAX_LOG_SIZE} ]]; then
        mv "${LOG_FILE}" "${LOG_FILE}.old"
        log_message "Log rotated"
    fi
}

# What?    Detect the type of changes for Conventional Commits
# For?     Automatically categorize commits (feat, docs, fix, etc.)
# Impact?  Consistent and meaningful commit messages
detect_commit_type() {
    local changed_files="$1"
    
    # What?    Check for documentation changes
    # For?     Categorize .md files as 'docs' type
    # Impact?  Clear distinction between code and documentation
    if echo "${changed_files}" | grep -qE '\.md$'; then
        if echo "${changed_files}" | grep -qvE '\.md$'; then
            # Mixed changes: code and docs
            echo "chore"
        else
            # Only markdown files
            echo "docs"
        fi
        return
    fi
    
    # What?    Check for SQL schema/structure changes
    # For?     Categorize DDL changes as 'feat' type
    # Impact?  New database features are properly tagged
    if echo "${changed_files}" | grep -qE '(CREATE|ALTER|DROP)' 2>/dev/null; then
        echo "feat"
        return
    fi
    
    # What?    Check for configuration changes
    # For?     Categorize config files appropriately
    # Impact?  Infrastructure changes are tracked separately
    if echo "${changed_files}" | grep -qE '\.(yml|yaml|json|toml|ini|env)$'; then
        echo "build"
        return
    fi
    
    # What?    Check for script changes
    # For?     Categorize shell/automation scripts
    # Impact?  Tooling changes are properly labeled
    if echo "${changed_files}" | grep -qE '\.(sh|zsh|bash)$'; then
        echo "ci"
        return
    fi
    
    # What?    Check for SQL files (exercises, practice)
    # For?     Most bootcamp content is SQL
    # Impact?  Learning content is tagged appropriately
    if echo "${changed_files}" | grep -qE '\.sql$'; then
        echo "feat"
        return
    fi
    
    # What?    Default commit type
    # For?     Catch-all for miscellaneous changes
    # Impact?  No changes go untagged
    echo "chore"
}

# What?    Generate scope based on changed directories
# For?     Add context to commit messages (e.g., semana-01)
# Impact?  Easy filtering and searching of commits by scope
detect_scope() {
    local changed_files="$1"
    
    # What?    Check for week-specific changes
    # For?     Scope commits to specific bootcamp weeks
    # Impact?  Clear tracking of progress per week
    local week=$(echo "${changed_files}" | grep -oE 'semana-[0-9]+' | head -1)
    if [[ -n "${week}" ]]; then
        echo "${week}"
        return
    fi
    
    # What?    Check for script changes
    # For?     Scope infrastructure/tooling commits
    # Impact?  Separate tooling from content
    if echo "${changed_files}" | grep -qE '^_scripts/'; then
        echo "scripts"
        return
    fi
    
    # What?    Check for asset changes
    # For?     Scope visual/media commits
    # Impact?  Track design changes separately
    if echo "${changed_files}" | grep -qE '^_assets/'; then
        echo "assets"
        return
    fi
    
    # What?    Check for documentation changes
    # For?     Scope general documentation
    # Impact?  Docs are clearly identified
    if echo "${changed_files}" | grep -qE '^_docs/'; then
        echo "docs"
        return
    fi
    
    # What?    No specific scope detected
    # For?     Root-level or mixed changes
    # Impact?  Commit message remains clean without scope
    echo ""
}

# What?    Count files by type for commit message
# For?     Provide summary of changes in commit body
# Impact?  Informative commit messages
count_changes() {
    local changed_files="$1"
    local sql_count=$(echo "${changed_files}" | grep -cE '\.sql$' || echo 0)
    local md_count=$(echo "${changed_files}" | grep -cE '\.md$' || echo 0)
    local other_count=$(echo "${changed_files}" | grep -cvE '\.(sql|md)$' || echo 0)
    
    local summary=""
    [[ ${sql_count} -gt 0 ]] && summary="${summary}${sql_count} SQL, "
    [[ ${md_count} -gt 0 ]] && summary="${summary}${md_count} MD, "
    [[ ${other_count} -gt 0 ]] && summary="${summary}${other_count} other, "
    
    # What?    Remove trailing comma and space
    # For?     Clean output formatting
    # Impact?  Professional commit messages
    echo "${summary%, }"
}

# --- Main Execution ---

# What?    Navigate to repository
# For?     Ensure git commands work correctly
# Impact?  Script works from cron (any pwd)
cd "${REPO_PATH}" || {
    echo "Error: Cannot access ${REPO_PATH}" >&2
    exit 1
}

# What?    Rotate log if needed
# For?     Maintenance task before main execution
# Impact?  Prevents log bloat
rotate_log

log_message "=== Autocommit started ==="

# What?    Check for uncommitted changes
# For?     Only commit if there are actual changes
# Impact?  Avoid empty commits and unnecessary git history
if git diff --quiet && git diff --cached --quiet; then
    log_message "No changes detected, skipping commit"
    exit 0
fi

# What?    Get list of changed files
# For?     Analyze changes for commit type and scope
# Impact?  Intelligent commit message generation
CHANGED_FILES=$(git status --porcelain | awk '{print $2}')
FILE_COUNT=$(echo "${CHANGED_FILES}" | wc -l | tr -d ' ')

log_message "Detected ${FILE_COUNT} changed file(s)"

# What?    Stage all changes
# For?     Prepare files for commit
# Impact?  All modifications are included
git add -A

# What?    Detect commit type and scope
# For?     Build Conventional Commits message
# Impact?  Standardized, searchable git history
COMMIT_TYPE=$(detect_commit_type "${CHANGED_FILES}")
COMMIT_SCOPE=$(detect_scope "${CHANGED_FILES}")
CHANGE_SUMMARY=$(count_changes "${CHANGED_FILES}")

# What?    Build commit message with scope if available
# For?     Follow Conventional Commits specification
# Impact?  Consistent commit format across project
if [[ -n "${COMMIT_SCOPE}" ]]; then
    COMMIT_SUBJECT="${COMMIT_TYPE}(${COMMIT_SCOPE}): auto-save ${FILE_COUNT} file(s)"
else
    COMMIT_SUBJECT="${COMMIT_TYPE}: auto-save ${FILE_COUNT} file(s)"
fi

# What?    Create commit body with details
# For?     Provide context about changes
# Impact?  Self-documenting git history
COMMIT_BODY="Files: ${CHANGE_SUMMARY}

Auto-committed by cron schedule.
Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"

# What?    Execute the commit
# For?     Save changes to git history
# Impact?  Work is preserved and tracked
git commit -m "${COMMIT_SUBJECT}" -m "${COMMIT_BODY}"

# What?    Log commit result
# For?     Track successful commits
# Impact?  Audit trail for debugging
COMMIT_HASH=$(git rev-parse --short HEAD)
log_message "Committed: ${COMMIT_HASH} - ${COMMIT_SUBJECT}"

log_message "=== Autocommit completed ==="

exit 0
