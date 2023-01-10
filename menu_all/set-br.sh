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
clear
cd
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
NC='\e[0m'
echo "Setting UP"
echo "Progress..."
sleep 3
echo ""
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted.."
else
red "Permission Denied!"
exit 0
fi
sleep 3
echo -e "
"
date
echo ""
sleep 1
echo -e "[ ${green}INFO${NC} ] Checking... "
sleep 2
sleep 1
echo -e "[ ${green}INFO${NC} ] Download & Install rclone... "
curl -fsSL https://rclone.org/install.sh | bash > /dev/null 2>&1
printf "q\n" | rclone config > /dev/null 2>&1
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading rclone config ... "
wget -q -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/FranataVPN/src/ipuk/bckp/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git &> /dev/null
cd wondershaper
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing wondershaper... "
make install > /dev/null 2>&1
cd
rm -rf wondershaper > /dev/null 2>&1
echo > /home/limit

pkgs='msmtp-mta ca-certificates bsd-mailx'
if ! dpkg -s $pkgs > /dev/null 2>&1; then
sleep 1
echo -e "[ ${green}INFO${NC} ] Installing... "
apt install -y $pkgs > /dev/null 2>&1
else
sleep 1
echo -e "[ ${green}INFO${NC} ] Already Installed... "
fi
sleep 1
echo -e "[ ${green}INFO${NC} ] Creating service... "

cat> /etc/msmtprc << EOF
account default
host smtp.gmail.com
port 587
from 3bulanmm@gmail.com
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
auth on
user 3bulanmm
password aww123321aww
logfile ~/.msmtp.log
EOF

chown -R www-data:www-data /etc/msmtprc
sleep 1
echo -e "[ ${green}INFO${NC} ] Downloading files... "
wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/FranataVPN/src/ipuk/bckp/backup.sh" && chmod +x /usr/bin/backup
wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/FranataVPN/src/ipuk/bckp/restore.sh" && chmod +x /usr/bin/restore
wget -q -O /usr/bin/cleaner "https://raw.githubusercontent.com/FranataVPN/src/ipuk/bckp/logcleaner.sh" && chmod +x /usr/bin/cleaner

if [ ! -f "/etc/cron.d/cleaner" ]; then
cat> /etc/cron.d/cleaner << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
* */6 * * * root /usr/bin/cleaner
END
fi

service cron restart > /dev/null 2>&1

rm -f /root/set-br.sh
