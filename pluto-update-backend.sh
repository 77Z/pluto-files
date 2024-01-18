#!/bin/bash

ensure_mounted()
{
	if ! [ -f /efimnt/EFI/PLUTO/grubenv ]; then
		mkdir -p /efimnt
		mount /dev/disk/by-label/PBOOT /efimnt
	fi
}


case ${1:-} in
get-primary)
	ensure_mounted

	# Grab TRY_BOOT_A value
	tryboota=$(grub-editenv /efimnt/EFI/PLUTO/grubenv list | rev | cut -c1)

	if [ "$tryboota" = "1" ]; then
		echo "A"
	else
		echo "B"
	fi

    ;;

set-primary)
	ensure_mounted

	if [ "${2:-}" = "A" ]; then
		grub-editenv /efimnt/EFI/PLUTO/grubenv set TRY_BOOT_A=1
    else
		grub-editenv /efimnt/EFI/PLUTO/grubenv set TRY_BOOT_A=0
	fi

    ;;

get-state)
    echo good
    ;;

set-state)
    ensure_mounted

    case ${3:-} in
        good)
            exit 0
            ;;
        bad)
            exit 0
            ;;
        *)
            echo "Bad image state value '${3:-}' { good; bad }" >&2
            exit 22
            ;;
    esac
    ;;

*)
    echo "${1:-(nil)}: Invalid argument" >&2
    exit 127
    ;;
esac
