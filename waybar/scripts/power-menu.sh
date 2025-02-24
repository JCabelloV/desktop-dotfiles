#!/bin/bash

# Mostrar menú con opciones usando rofi (o zenity si prefieres)
option=$(echo -e " Apagar\n Reiniciar\n Cambiar de Usuario" | rofi -dmenu -i -p "Elige una opción:")

case $option in
    " Apagar")
        systemctl poweroff
        ;;
    " Reiniciar")
        systemctl reboot
        ;;
    " Cambiar de Usuario")
        dm-tool switch-to-greeter
        ;;
    *)
        echo "Opción no válida o cancelada"
        ;;
esac

