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
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m              TRIAL MENU GENERATOR              \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;37mNB: Trial account will not logged into create log user\033[0m
\033[1;32mTrial-Generator\033[0m :

[\033[0;32m01\033[0m] • Generate Trial SSH 
[\033[0;32m02\033[0m] • Generate Trial Wireguard
[\033[0;32m03\033[0m] • Generate Trial L2TP
[\033[0;32m04\033[0m] • Generate Trial PPTP
[\033[0;32m05\033[0m] • Generate Trial SSTP
[\033[0;32m06\033[0m] • Generate Trial Shadowsocks-R
[\033[0;32m07\033[0m] • Generate Trial Shadowsocks
[\033[0;32m08\033[0m] • Generate Trial Vmess
[\033[0;32m09\033[0m] • Generate Trial VLESS
[\033[0;32m10\033[0m] • Generate Trial Trojan WS/GRPC

[00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -ne "Select menu : "; read x

case "$x" in 
   1 | 01)
   clear
   trial
   ;;
   2 | 02)
   clear
   trial-wg
   ;;
   3 | 03)
   clear
   trial-l2tp
   ;;
   4 | 04)
   clear
   trial-pptp
   ;;
   5 | 05)
   clear
   trial-sstp
   ;;
   6 | 06)
   clear
   trial-ssr
   ;;
   7 | 07)
   clear
   trial-ss
   ;;
   8 | 08)
   clear
   trial-ws
   ;;
   9 | 09)
   clear
   trial-vless
   ;;
   10)
   clear
   trial-tr
   ;;
   11)
   clear
   trial-trgo
   ;;
   0 | 00)
   clear
   menu
   ;;
   *)
   info-menu
esac

#fim