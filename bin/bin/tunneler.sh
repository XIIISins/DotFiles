#!/bin/bash
#
# Automagically create SSH tunnel to remote host on port 9090
#

PYPROX=python_proxy.py
LOCIP=
SSHCMD="ssh -R 9090:${LOCIP}:8080 ${r_user}@${r_host}"
TMPLOGDIR=$HOME/tmp
TMPLOGFIL=tunneler.log

if [ ! -d $TMPLOGDIR ]; then
  echo "Creating logdir in $TMPLOGDIR"
  mkdir -p $TMPLOGDIR
fi

LOGFILE_prx=${TMPLOGDIR}/prx.${TMPLOGFIL}
LOGFILE_ssh=${TMPLOGDIR}/ssh.${TMPLOGFIL}

if [ $# -eq 0 ]; then
  echo "No arguments given, exit"
  echo "Usage $0: $0 -l 10.0.1.204 -u root -h 8.8.8.8"
  exit 1
fi

while getopts "l:u:h:" options; do
  case $options in
    l)
      export LOCIP=$OPTARG
      ;;
    u)
      export r_user=$OPTARG
      ;;
    h)
      export r_host=$OPTARG
      ;;
  esac
done

SSHCMD="ssh -R 9090:${LOCIP}:8080 ${r_user}@${r_host}"

# From here we actually do stuff, I think
#echo "Starting up proxy, see logfile ($LOGFILE_prx) for details"
#python2 $PYPROX 2>&1 | tee $LOGFILE_prx


echo "Executing: $SSHCMD"
$SSHCMD | tee $LOGFILE_ssh
