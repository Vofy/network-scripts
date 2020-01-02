SHORT_SLEEP=2
LONG_SLEEP=10

BLUE='\e[0;34m'
RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m'

echo "
Starting ${BLUE}PortProbe${NC} script by ${BLUE}VOFY | TECHNOLOGIES (Tomáš Batelka)${NC}
----------------------------------------------------------------
"

INTERFACE="$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')"
echo "Wired interface detected ${BLUE}$INTERFACE${NC}
"

echo "Setting interface ${RED}$INTERFACE${NC} down"
ip link set dev $INTERFACE down

echo "
"

while true
do
	for i in 1 2 3
	do
		echo "Setting interface ${GREEN}$INTERFACE${NC} up        - ${SHORT_SLEEP}s"
		ip link set dev $INTERFACE up
		sleep $SHORT_SLEEP

		echo "Setting interface ${RED}$INTERFACE${NC} down"
		ip link set dev $INTERFACE down
		sleep $SHORT_SLEEP

		echo
	done

	echo "Setting interface ${GREEN}$INTERFACE${NC} up        - ${LONG_SLEEP}s"
	ip link set dev $INTERFACE up
	sleep $LONG_SLEEP

	echo "Setting interface ${RED}$INTERFACE${NC} down"
	ip link set dev $INTERFACE down
	sleep $SHORT_SLEEP

	echo
done
