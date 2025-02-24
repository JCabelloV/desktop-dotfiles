
# Este archivo es para almacenar el tiempo, en caso de que se cierre sesion con el timer activo
TIMER_FILE="/tmp/waybar_timer"

# Configurar el temporizador segun el tiempo que se de como argumento
if [ "$1" == "set" ]; then
    DURATION=$(echo -e "1\n5\n10\n15\n20\n30\n60" | wofi --dmenu --prompt "Selecciona la duración del temporizador (min):")
    if [ -z "$DURATION" ]; then
        exit 1  # Salir 
    fi

    # Pasar el tiempo a minutos para trabajarlo en la terminal
    TIMER_DURATION=$(( DURATION * 60 ))

    # Iniciar con la duracion establecida
    echo "$TIMER_DURATION" > "$TIMER_FILE"
    notify-send "⏰ Temporizador iniciado" "Duración: $DURATION minutos" #Mandar notificacion para cuando el temporizador termina
    exit 0
fi

# Si no hay archivo temporal, muestra "Inactivo"
if [ ! -f "$TIMER_FILE" ]; then
    echo "󰁫 Timer: Inactivo"
    exit 0
fi

# Calcula el tiempo restante
TIME_LEFT=$(cat "$TIMER_FILE")

if [ "$TIME_LEFT" -le 0 ]; then
    echo "󰁫 Timer: 00:00"
    rm -f "$TIMER_FILE"
    notify-send "⏰ Temporizador terminado" "El temporizador ha finalizado."
    exit 0
else
    echo "󰁫 Timer: $(date -u -d @$TIME_LEFT +%M:%S)"
    echo $((TIME_LEFT - 1)) > "$TIMER_FILE"
    exit 0
fi

# Luego de esto se esta ejecutando constantemente en el archivo de configuracion de waybar para reconocer si esta activo y disminuir los segundos o para reconocer si esta inactivo y mostrarlo en la barra
