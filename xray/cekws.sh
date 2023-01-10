#!/bin/bash
#########################

clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo "--------------------------------";
echo "-----=[ XRAY USER LOGIN ]=------";
echo "--------------------------------";for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
log=$(tail -1 /var/log/xray/access.log | grep "$akun" | awk '{print $2}');
for login in "${log[@]}"
do
echo -n > /tmp/ipvmess.txt
data2=$(tail /var/log/xray/access.log | grep "$akun" | cut -d: -f3 | awk '{print $2}' | sort | uniq);
for ip in "${data2[@]}"
do
jum=$(tail /var/log/xray/access.log | grep "$akun" | awk '{print $3}' | cut -d: -f1 | grep "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo -e "${GREEN}User : $akun ${NC}";
echo -e "${RED}Last Login: $login${NC}"
echo "$jum2";
echo "--------------------------------"
fi
rm -rf /tmp/ipvmess.txt
done
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo "$oth";
echo "--------------------------------"
rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
