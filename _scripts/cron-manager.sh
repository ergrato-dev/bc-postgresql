#!/bin/zsh
# ============================================
# Cron Installer - Autocommit Script
# ============================================
# What?    Script to install/uninstall autocommit cron job
# For?     Easy setup and removal of automatic commits
# Impact?  One-command setup for autocommit functionality
# ============================================

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AUTOCOMMIT_SCRIPT="${SCRIPT_DIR}/autocommit.sh"
CRON_SCHEDULE="*/5 * * * *"  # Every 5 minutes
CRON_COMMENT="# bc-postgresql-autocommit"

# --- Functions ---

# What?    Display usage information
# For?     Help users understand available commands
# Impact?  Better user experience
show_usage() {
    echo "============================================"
    echo "Autocommit Cron Manager"
    echo "============================================"
    echo ""
    echo "Uso:"
    echo "  $0 install    - Instala el cron job (cada 5 minutos)"
    echo "  $0 uninstall  - Elimina el cron job"
    echo "  $0 status     - Muestra el estado actual"
    echo "  $0 test       - Ejecuta el script manualmente"
    echo ""
    echo "============================================"
}

# What?    Check if autocommit script exists and is executable
# For?     Validate prerequisites before installation
# Impact?  Prevents broken cron jobs
check_prerequisites() {
    if [[ ! -f "${AUTOCOMMIT_SCRIPT}" ]]; then
        echo "❌ Error: No se encontró ${AUTOCOMMIT_SCRIPT}"
        exit 1
    fi
    
    if [[ ! -x "${AUTOCOMMIT_SCRIPT}" ]]; then
        echo "⚙️  Haciendo ejecutable el script..."
        chmod +x "${AUTOCOMMIT_SCRIPT}"
    fi
    
    echo "✅ Prerequisitos verificados"
}

# What?    Install the cron job
# For?     Enable automatic commits every 5 minutes
# Impact?  Continuous backup of work progress
install_cron() {
    check_prerequisites
    
    # What?    Check if already installed
    # For?     Prevent duplicate cron entries
    # Impact?  Clean crontab without duplicates
    if crontab -l 2>/dev/null | grep -q "${CRON_COMMENT}"; then
        echo "⚠️  El cron job ya está instalado"
        echo "   Usa '$0 uninstall' primero si deseas reinstalar"
        exit 0
    fi
    
    # What?    Add cron job to crontab
    # For?     Schedule automatic commits
    # Impact?  Script runs every 5 minutes
    (crontab -l 2>/dev/null; echo "${CRON_COMMENT}"; echo "${CRON_SCHEDULE} ${AUTOCOMMIT_SCRIPT}") | crontab -
    
    echo "✅ Cron job instalado exitosamente"
    echo ""
    echo "📅 Configuración:"
    echo "   Frecuencia: Cada 5 minutos"
    echo "   Script: ${AUTOCOMMIT_SCRIPT}"
    echo ""
    echo "💡 Tips:"
    echo "   - Usa '$0 status' para verificar el estado"
    echo "   - Usa '$0 uninstall' para desactivar"
    echo "   - Los logs están en: ${SCRIPT_DIR}/autocommit.log"
}

# What?    Remove the cron job
# For?     Disable automatic commits
# Impact?  No more automatic commits (manual only)
uninstall_cron() {
    # What?    Check if installed
    # For?     Provide feedback if nothing to remove
    # Impact?  Clear user communication
    if ! crontab -l 2>/dev/null | grep -q "${CRON_COMMENT}"; then
        echo "⚠️  No hay cron job instalado"
        exit 0
    fi
    
    # What?    Remove cron entries related to autocommit
    # For?     Clean uninstall
    # Impact?  Crontab returns to previous state
    crontab -l 2>/dev/null | grep -v "${CRON_COMMENT}" | grep -v "${AUTOCOMMIT_SCRIPT}" | crontab -
    
    echo "✅ Cron job eliminado exitosamente"
    echo "   Los commits automáticos están desactivados"
}

# What?    Show current cron status
# For?     Verify installation and configuration
# Impact?  Quick status check for troubleshooting
show_status() {
    echo "============================================"
    echo "Estado del Autocommit"
    echo "============================================"
    echo ""
    
    # What?    Check if script exists
    # For?     Verify file presence
    # Impact?  Basic health check
    if [[ -f "${AUTOCOMMIT_SCRIPT}" ]]; then
        echo "📄 Script: ✅ Existe"
        if [[ -x "${AUTOCOMMIT_SCRIPT}" ]]; then
            echo "   Permisos: ✅ Ejecutable"
        else
            echo "   Permisos: ❌ No ejecutable"
        fi
    else
        echo "📄 Script: ❌ No encontrado"
    fi
    
    echo ""
    
    # What?    Check cron status
    # For?     Verify cron job is active
    # Impact?  Confirm autocommit is running
    if crontab -l 2>/dev/null | grep -q "${CRON_COMMENT}"; then
        echo "⏰ Cron: ✅ Instalado"
        echo "   Schedule: Cada 5 minutos"
        echo ""
        echo "   Entrada actual:"
        crontab -l 2>/dev/null | grep -A1 "${CRON_COMMENT}"
    else
        echo "⏰ Cron: ❌ No instalado"
    fi
    
    echo ""
    
    # What?    Show recent log entries
    # For?     Quick view of recent activity
    # Impact?  Easy monitoring
    local log_file="${SCRIPT_DIR}/autocommit.log"
    if [[ -f "${log_file}" ]]; then
        echo "📋 Últimas 5 entradas del log:"
        echo "---"
        tail -10 "${log_file}" | grep -E '^\[' | tail -5
        echo "---"
    else
        echo "📋 Log: No existe aún (se creará en el primer commit)"
    fi
    
    echo ""
    echo "============================================"
}

# What?    Run autocommit manually
# For?     Testing and immediate commits
# Impact?  Verify script works correctly
run_test() {
    check_prerequisites
    
    echo "🧪 Ejecutando autocommit manualmente..."
    echo ""
    
    "${AUTOCOMMIT_SCRIPT}"
    
    echo ""
    echo "✅ Test completado"
    echo "   Revisa el log para más detalles"
}

# --- Main ---

case "${1}" in
    install)
        install_cron
        ;;
    uninstall)
        uninstall_cron
        ;;
    status)
        show_status
        ;;
    test)
        run_test
        ;;
    *)
        show_usage
        exit 1
        ;;
esac

exit 0
