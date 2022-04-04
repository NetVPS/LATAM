#!/bin/bash
#Soporte Remoto (SPR)
fun_bar() {
    comando="$1"
    fix=" \e[1;97m$2"
    _=$(
        $comando >/dev/null 2>&1
    ) &
    >/dev/null
    pid=$!
    while [[ -d /proc/$pid ]]; do
        echo -ne "\e[1;93m APLICANDO FIX:"$fix"\n \033[1;33m["
        for ((i = 0; i < 10; i++)); do
            echo -ne "\033[1;31m##"
            sleep 0.2
        done
        echo -ne "\033[1;33m]"
        sleep 1s
        echo
        tput cuu1 && tput dl1
        tput cuu1 && tput dl1
    done

    echo -ne "\e[1;93m APLICANDO FIX:"$fix"\n \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32mOK\033[0m\n"
    sleep 1s
}
###CODIGO DE FIX
clear && clear
echo -e "\e[1;93m————————————————————————————————————————————————————"
echo -e "\033[1;97m             VERIFICANDO ERRORES v1.6"
echo -e "\e[1;93m————————————————————————————————————————————————————"

reset_drop() {
    sed -i "s/=1/=0/g" /etc/default/dropbear
    service dropbear restart
    sed -i "s/=0/=1/g" /etc/default/dropbear

}
if [[ "$1" = "rd" ]]; then
    fun_bar "reset_drop" "FIX BANNER DROPBEAR"
fi

selec_lag() {
    sudo apt-get -y install language-pack-en-base
    export LANGUAGE=en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8 && export LC_CTYPE="en_US.UTF-8" &&
        locale-gen en_US.UTF-8
}
if [[ "$1" = "es" ]]; then
    fun_bar "selec_lag" "FIX LEGUAGE"
    sudo dpkg-reconfigure locales
fi

apt install at -y &>/dev/null

# echo "nameserver 1.1.1.1 " >/etc/resolv.conf
# echo "nameserver 1.0.0.1 " >>/etc/resolv.conf

# dpkg --configure -a >/dev/null 2>&1
# apt -f install -y >/dev/null 2>&1

# apt update >/dev/null 2>&1
# apt upgrade -y >/dev/null 2>&1

wget -O /bin/rebootnb https://www.dropbox.com/s/8thnqvw2ljvjelw/rebootnb.sh &>/dev/null
chmod +x /bin/rebootnb

echo -e "\e[1;93m————————————————————————————————————————————————————"
exit
