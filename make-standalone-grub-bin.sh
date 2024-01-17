grub-mkstandalone -d /usr/lib/grub/x86_64-efi -O x86_64-efi --modules="part_gpt part_msdos" --locales="en@quot" --themes="" -o ./pluto-bootloader.efi "boot/grub/grub.cfg=/tmp/grub.cfg" -v
