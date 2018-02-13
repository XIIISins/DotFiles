#!/bin/bash
## System status script, work on Arch and OEL
##

OS=$(uname -sr)
ARCH=$(uname -m)
CURTIME=$(date +'%H:%M:%S (%d/%m/%Y)')
UPTIME=$(uptime | awk '{print $3}')
HOSTNAME=$(uname -n)
LOAD=$(uptime | awk '{print $10,$11,$12}')
MEM=$(free -m | awk '/Mem:/ {print $3,"mb used,",$4,"mb free"}')
PROCS=$(ps -A | wc -l)
#CPUMODEL=$(grep -m1 '' /proc/cpuinfo)
CPUMODEL=$(grep -m1 "model name" /proc/cpuinfo  | cut -f3- -d ' ')
#CPUS=$(grep -c processor: /proc/cpuinfo)
CPUS=$(grep -c processor /proc/cpuinfo )
TOTALRAM=$(free -m | awk '/Mem:/ {print $2,"mb"}')
#VPN=`ps aux | grep -i v[p]nc | awk '{ s = ""; for (i = 11; i <= NF; i++) s = s $i " "; print s }'`
VPN=$(grep -c tun /proc/net/dev)
DNS=$(grep nameserver /etc/resolv.conf )
IPDOMAIN=$(grep domain /etc/resolv.conf | awk '{print $2}')
INTERFACE=$(awk -F : '{ print $1 }' /proc/net/dev | sed 's/:/ /g' | grep -Piv 'inter|face')


function system_status {
    cat << _EOM
    OS: $OS
    Platform: $ARCH
    Time: $CURTIME
    Uptime: ${UPTIME::-1}
_EOM
}

function network {
    cat << _EOM
    Hostname: $HOSTNAME
    Domain: $IPDOMAIN
_EOM
    for D in $DNS
    do
	if [ "$D" != "nameserver" ]; then
	    echo -e "    nameserver: $D"
	fi
    done

}

function vpn {
    cat << _EOM
    VPN Status: $VPN
_EOM
}

function interfaces () {
version="ifconfig"
IPTool=$(which ifconfig 2>/dev/null)
if [ "$IPTool" == "" ]; then
  version="ip"
  IPTool=$(which ip 2>/dev/null)
fi
if [ "$version" == "ip" ]; then
    cat << _EOM
    $1=$($IPTool addr | grep "$1" | awk '/inet / {print $2}')
_EOM
else
    cat << _EOM
    $1=$($IPTool "$1" | awk '/inet / {print $2}')
_EOM
fi
}
function system_usage {
    cat << _EOM
    SYSTEM USAGE:

    Load: $LOAD
    Memory: $MEM
    Tasks: $PROCS
_EOM
}

function hardware {
if [ "$(lspci | grep -c "VMware" )" -gt 0 ]; then
    VIRTUAL_MACHINE="TRUE"
    cat << _EOM
    HARDWARE:

    VIRTUAL MACHINE

_EOM
else
    cat << _EOM
    HARDWARE:

    CPU: $CPUMODEL
    Cores/Processors: $CPUS
    RAM: $TOTALRAM
_EOM
fi
}

function vmware_info
{
        VMTool=$(which vmware-toolbox-cmd)
        if [ "$VMTool" != "" ]; then
                VMVersion=$($VMTool --version)
                if [ "${VMVersion::1}" == "9" ]; then
                        VMStatus=$($VMTool upgrade status)
                else
                        VMStatus="***UNKNOWN***"
                fi
        fi
   cat << _EOM
    VMWare Tools Version: $VMVersion
    VMWare Tools status : $VMStatus
_EOM
}


function starline {

cat <<_EOM
    ********************
_EOM
}

if [ "$IPDOMAIN" == "" ]; then
    IPDOMAIN=$(grep search /etc/resolv.conf | awk '{print$2}')
fi

if [ "$VPN" -gt 0 ]; then
    VPN="on"
else
    VPN="off"
fi

function oracle_status {
if [ -f /etc/oratab ]; then
cat << _EOM
    DATABASE:

_EOM
grep -e "^[a-Z]" /etc/oratab > ."${0}".tmp
while read -r line
do
  ORACLE_SID=$(echo "$line"|awk -F ":" '{print $1}')
  ORACLE_HOME=$(echo "$line"|awk -F ":" '{print $2}')
  ORACLE_START=$(echo "$line"|awk -F ":" '{print $3}')
  ORACLE_RUNNING=$(pgrep -c "ora_[p]mon_${ORACLE_SID}")
  if [ "$ORACLE_RUNNING" == "1" ]; then
    ORACLE_RUNNING="TRUE"
  else
    ORACLE_RUNNING="FALSE"
  fi
    cat << _EOM
    ORACLE_SID: $ORACLE_SID	ORACLE_HOME: $ORACLE_HOME	AUTOSTART: $ORACLE_START	RUNNING: $ORACLE_RUNNING
_EOM
done < ."${0}".tmp
rm ."${0}".tmp
starline
fi
}

function zabbix_status {
ZABBIX_PROCESS=$(pgrep -c [z]abbix_agentd )
if [ "$ZABBIX_PROCESS" -gt 1 ]; then
    ZABBIX_RUNNING="TRUE"
    ZABBIX_AGENT=$(which zabbix_agent 2>/dev/null)
    ZABBIX_VERSION=$($ZABBIX_AGENT --version | grep Zabbix | awk '{print $3}')
    cat << _EOM
    MONITORING:

    Zabbix Version: $ZABBIX_VERSION	Zabbix Running: $ZABBIX_RUNNING
_EOM
starline
fi
}

#########################################
##########__MAIN ROUTINE___##############
#########################################
echo -e ""
starline
system_status
starline
oracle_status
zabbix_status
network
vpn
for I in $INTERFACE
do
    if [ "${I}" != "lo" ]; then
	interfaces "$I"
    fi
done
starline
system_usage
starline
#determine_hardware
hardware
if [ "$VIRTUAL_MACHINE" == "TRUE" ]; then
  vmware_info
fi
starline
