#!/bin/bash
# Menu For Script
# Edition : Stable Edition V1.0
# Auther  : FRANATA STORE
# (C) Copyright 2021-2023 BY FRANATA STORE
# =========================================
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

PERMISSION

if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://raw.githubusercontent.com/FranataVPN/izinvps/ipuk/ip | grep $MYIP | awk '{print $3}')
fi

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="XdrgVPN"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-epro | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

clear
clear
clear
clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[45;1;39m                     ⇱ INFORMASI VPS ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo -e "${PURPLE} ✘ ${NC}Sever Uptime        = $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "${PURPLE} ✘ ${NC}Current Time        = $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "${PURPLE} ✘ ${NC}Operating System    = $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) )"
echo -e "${PURPLE} ✘ ${NC}Current Domain      = $( cat /etc/xray/domain )"
echo -e "${PURPLE} ✘ ${NC}Server IP           = ${IP}"
echo -e "${PURPLE} ✘ ${NC}Clients Name        = $Name"
echo -e "${PURPLE} ✘ ${NC}Script Expert       = $Exp"
echo -e "${PURPLE} ✘ ${NC}VPS Reboot          = Jam 12 Malam ${NC}"
echo -e "${PURPLE} ✘ ${NC}Versi Script        = PREMIUM${NC}"
echo -e "${PURPLE} ✘ ${NC}Developer           = FRANATA STORE${NC}"

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[45;1;39m                     ⇱ STATUS SERVER ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""


echo -e " ${PURPLE}CRON${NC}          :  ${GREEN}ON"
echo -e " ${PURPLE}FAIL2BAN${NC}      :  ${GREEN}ON"
echo -e " ${PURPLE}DROPBEAR ${NC}     :  ${GREEN}ON"
echo -e " ${PURPLE}WEBSOCKET${NC}     :  ${GREEN}ON"
echo -e " ${PURPLE}XRAY${NC}          :  ${status_xray} "
echo -e " ${PURPLE}NGINX${NC}         :  ${status_nginx} "
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[45;1;39m                       ⇱ MENU SERVER ⇲                        \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
echo -e " [${PURPLE}01${NC}]${NC} Add Ssh   $NC "
echo -e " [${PURPLE}02${NC}]${NC} Add V2ray     $NC  "
echo -e " [${PURPLE}03${NC}]${NC} Add Trojan    $NC"
echo -e " [${PURPLE}04${NC}]${NC} Add Sodosok  $NC"
echo -e " [${PURPLE}05${NC}]${NC} Add Trial    $NC"
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[45;1;39m                       ⇱ MENU SETTING ⇲                       \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""
echo -e " [${PURPLE}06${NC}]${NC} Running Service $NC"
echo -e " [${PURPLE}07${NC}]${NC} Certificate SSL $NC   "
echo -e " [${PURPLE}08${NC}]${NC} Cek Trafik Xray $NC"
echo -e " [${PURPLE}09${NC}]${NC} Info Dev  $NC"
echo -e " [${PURPLE}10${NC}]${NC} Speedtest  $NC"
echo -e " [${PURPLE}11${NC}]${NC} Add Domain    $NC"
echo -e " [${PURPLE}12${NC}]${NC} Change Banner $NC"
echo -e " [${PURPLE}13${NC}]${NC} Cek Bandwith User Xray $NC"
echo -e " [${PURPLE}14${NC}]${NC} Change Password VPS $NC"
echo -e " [${PURPLE}15${NC}]${NC} CEK LOGIN XRAY $NC"
echo -e " [${PURPLE}16${NC}]${NC} REBOOT VPS $NC"
echo -e " ${RED}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[45;1;39m                      ⇱ FRANATA STORE ⇲                       \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e ""

read -p "Select From Options [ 1 - 14 ] : " menu
case $menu in
1)
clear
ssh-menu
;;
2)
clear
v2ray-menu
;;
3)
clear
trojan-menu
;;
4)
clear
add-ssws
;;
5)
clear
trial-menu
;;
6)
clear
running
;;
7)
clear
crtv2ray
;;
8)
clear
cekusage
;;
9)
clear
about
;;
10)
clear
speedtest
;;
11)
clear
add-host
;;
12)
clear
banner
;;
13)
clear
info-menu
;;
14)
clear
passwd
;;
15)
clear
cekxrayb
;;
16)
reboot
exit
;;
*)
clear
menu
;;
esac
