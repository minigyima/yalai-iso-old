rm /etc/pacman.conf
mv .pacman.conf /etc/pacman.conf
pacman -Syy
echo "Pacman should be ready..." 
mv .xinitrc /etc/X11/xinit/
