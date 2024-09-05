#!/bin/bash

apt update ; apt install ssh chromium openbox lightdm unclutter x11vnc -y

echo "[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwd semsenha
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> /lib/systemd/system/x11vnc.service

echo "[SeatDefaults]
autologin-user=totem
user-session=openbox" >> /etc/lightdm/lightdm.conf

useradd -m totem && mkdir -p /home/totem/.config/openbox

echo "xset -dpms s off &
unclutter -idle 0 &
chromium --no-first-run --disable --disable-translate --disable-infobars --disable-suggestions-service --disable-save-password-bubble --start-maximized --incognito --kiosk https://pesquisasatisfacao.saude.rj.gov.br/unidade/BuscaTipoQuestionario/2298031 &" >> /home/totem/.config/openbox/autostart

chown -R totem:totem /home/totem/.config/ && chmod -R 700 /home/totem/.config/

reboot
