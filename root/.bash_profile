#!/bin/sh
v4Addr=$(ip route get 8.8.8.8 | head -1 | cut -d' ' -f7)
v6Addr=$(ip -6 route get 2001:4860:4860::8888 | head -1 | cut -d' ' -f9)
v4Session=$(docker ps -a | grep '_v4' | wc -l)
v6Session=$(docker ps -a | grep '_v6' | wc -l)
v4Active=$(docker ps | grep '_v4' | wc -l)
v6Active=$(docker ps | grep '_v6' | wc -l)
v4Inactive=$(docker container ls -f 'status=exited' -f 'status=dead' -f 'status=created' | grep '_v4' | head -1 | wc -l)
v6Inactive=$(docker container ls -f 'status=exited' -f 'status=dead' -f 'status=created' | grep '_v6' | head -1 | wc -l)
RS1Status=$(docker ps | grep '_RS1' && echo -e "\e[1;32mONLINE\e[1m\e[0m" || echo -e "\e[1;31mOFFLINE\e[1m\e[0m")
RS2Status=$(docker ps | grep '_RS2' && echo -e "\e[1;32mONLINE\e[1m\e[0m" || echo -e "\e[1;31mOFFLINE\e[1m\e[0m")
#memUsage=$(free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
#disUsage=$(df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}')
#cpuUsage=$(top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", "$(NF-2")}' )
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`
        clear
        echo ""
        echo -e "\e[32m      ::::::::   ::::::::  ::::::::::     :::     ::::    ::: ::::::::::: :::    ::: \e[1m"
        echo -e "\e[32m    :+:    :+: :+:    :+: :+:          :+: :+:   :+:+:   :+:     :+:     :+:    :+:  \e[1m"
        echo -e "\e[32m   +:+    +:+ +:+        +:+         +:+   +:+  :+:+:+  +:+     +:+      +:+  +:+    \e[1m"
        echo -e "\e[32m  +#+    +:+ +#+        +#++:++#   +#++:++#++: +#+ +:+ +#+     +#+       +#++:+      \e[1m"
        echo -e "\e[32m +#+    +#+ +#+        +#+        +#+     +#+ +#+  +#+#+#     +#+      +#+  +#+      \e[1m"
        echo -e "\e[32m#+#    #+# #+#    #+# #+#        #+#     #+# #+#   #+#+#     #+#     #+#    #+#      \e[1m"
        echo -e "\e[32m########   ########  ########## ###     ### ###    #### ########### ###    ###       \e[1m"
        echo -e "\e[0m"
        echo -e "\e[1;35mSystem Uptime: $UPTIME \e[1m\e[0m"
        echo "IPv4: $v4Addr - IPv6: $v6Addr"
        echo "Route Server 1 Status: $RS1Status"
        echo "Route Server 2 Status: $RS2Status"
        echo "IPv4 Sessions: $v4Session (Active: $v4Active Inactive: $v4Inactive)"
        echo "IPv6 Sessions: $v6Session (Active: $v6Active Inactive: $v6Inactive)"
        echo ""
        echo "For OceanIXP Commands, Please Use The Command 'oceanixp_help'"
