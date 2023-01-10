#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/FranataVPN/izinvps/ipuk/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/FranataVPN/izinvps/ipuk/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/FranataVPN/izinvps/ipuk/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear

x="ok"

cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
kjj='xray'
else
kjj='v2ray'
fi
[[ -f /etc/ontorrent ]] && sts="\033[0;32mON \033[0m" || sts="\033[1;31mOFF\033[0m"

enabletorrent() {
[[ ! -f /etc/ontorrent ]] && {
sudo iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
sudo iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
sudo iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
sudo iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
sudo iptables-save > /etc/iptables.up.rules
sudo iptables-restore -t < /etc/iptables.up.rules
sudo netfilter-persistent save >/dev/null 2>&1
sudo netfilter-persistent reload >/dev/null 2>&1
touch /etc/ontorrent
setting-menu
} || {
sudo iptables -D FORWARD -m string --string "get_peers" --algo bm -j DROP
sudo iptables -D FORWARD -m string --string "announce_peer" --algo bm -j DROP
sudo iptables -D FORWARD -m string --string "find_node" --algo bm -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "BitTorrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "peer_id=" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string ".torrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "torrent" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "announce" -j DROP
sudo iptables -D FORWARD -m string --algo bm --string "info_hash" -j DROP
sudo iptables-save > /etc/iptables.up.rules
sudo iptables-restore -t < /etc/iptables.up.rules
sudo netfilter-persistent save >/dev/null 2>&1
sudo netfilter-persistent reload >/dev/null 2>&1
rm -f /etc/ontorrent
setting-menu
}
}

while true $x != "ok"
do

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m                  SETTINGS  MENU                  \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33mSettings\033[0m :

[\033[0;32m01\033[0m] • Add/Change VPS Host Subdomain
[\033[0;32m02\033[0m] • Add Subdomain to Cloudflare
[\033[0;32m03\033[0m] • Add Pointing Bug
[\033[0;32m04\033[0m] • Renew Certificate $kjj
[\033[0;32m05\033[0m] • Change Banner VPS
[\033[0;32m06\033[0m] • Change VPS Auto Reboot Time
[\033[0;32m07\033[0m] • Limit Bandwidth Speed Server
[\033[0;32m100\033[0m] • Restart All Service
[\033[0;32m101\033[0m] • Disable Torrent $sts
[\033[0;32m102\033[0m] • Ram Cache Cleaner

\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33mChange-Port\033[0m :

[\033[0;32m08\033[0m] • Change Port Stunnel4
[\033[0;32m09\033[0m] • Change Port OpenVPN
[\033[0;32m10\033[0m] • Change Port Wireguard
[\033[0;32m11\033[0m] • Change Port Vmess+Vless
[\033[0;32m12\033[0m] • Change Port Trojan
[\033[0;32m13\033[0m] • Change Port Trojan-GO
[\033[0;32m14\033[0m] • Change Port Squid
[\033[0;32m15\033[0m] • Change Port SSTP
[\033[0;32m16\033[0m] • Change Port SHDO WS
[\033[0;32m17\033[0m] • Change Port SHSSL WS
[00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -ne "Select menu : "; read x

case "$x" in 
   1 | 01)
   clear
   add-host
   break
   ;;
   2 | 02)
   clear
   cloudflare-setting
   break
   ;;
   3 | 03)
   clear
   cloudflare-pointing
   break
   ;;
   4 | 04)
   clear
   renewcert
   break
   ;;
   5 | 05)
   clear
   banner
   break
   ;;
   6 | 06)
   clear
   autoreboot
   break
   ;;
   7 | 07)
   clear
   limit-speed
   break
   ;;
   8 | 08)
   clear
   port-ssl
   break
   ;;
   9 | 09)
   clear
   port-ovpn
   break
   ;;
   10)
   clear
   port-wg
   break
   ;;
   11)
   clear
   port-ws
   break
   ;;
   12)
   clear
   port-tr
   break
   ;;
   13)
   clear
   port-trgo
   break
   ;;
   14)
   clear
   port-squid
   break
   ;;
   15)
   clear
   port-sstp
   break
   ;;
   16)
   clear
   port-dropbear
   break
   ;;
   17)
   clear
   port-wssl
   break
   ;;
   18)
   clear
   portohp
   break
   ;;
   19)
   clear
   portxtls
   break
   ;;
   100)
   clear
   restart-service
   break
   ;;
   101)
   clear
   enabletorrent
   break
   ;;
   102)
   echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram Cache Cleared'
   setting-menu
   break
   ;;
   0 | 00)
   clear
   menu
   break
   ;;
   *)
   clear
esac
done
#fim
