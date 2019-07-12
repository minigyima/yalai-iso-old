#!/bin/bash
set -e -u

#lang
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

#zsh,home
usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

#ssh,pacman,journal
sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf


sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

#systemd_services
systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
systemctl enable NetworkManager
systemctl start NetworkManager
