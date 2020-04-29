#!/bin/bash

SHORT_SLEEP=2
LONG_SLEEP=10

BLUE='\e[0;34m'
RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m'

exitCheck () {
    read -n 1 -t 0.1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]
    then
        printf "\n\nSetting interface ${GREEN}${INTERFACE}${NC} up\n"
        ip link set dev ${INTERFACE} up
        printf "\nExiting and thank you for using my script ${RED}♥${NC}\n\n"
        exit 1
    fi
}

printf "
Starting ${BLUE}PortProbe${NC} script by ${BLUE}VOFY | TECHNOLOGIES (Tomáš Batelka)${NC}
----------------------------------------------------------------
For exit script press ${BLUE}q${NC} and wait if you break this script interface can still be set on down\n\n"

INTERFACE="$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')"
printf "Wired interface detected ${BLUE}${INTERFACE}${NC}\n\n"

while true
do
	printf "Setting interface ${RED}${INTERFACE}${NC} down      - ${SHORT_SLEEP}s\n"
    ip link set dev ${INTERFACE} down
    sleep ${SHORT_SLEEP}
    exitCheck
    
    printf "Setting interface $GREEN${INTERFACE}${NC} up        - ${LONG_SLEEP}s\n\n"
    ip link set dev ${INTERFACE} up
    sleep ${LONG_SLEEP}
    exitCheck
done