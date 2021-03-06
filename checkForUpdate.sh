#!/bin/bash
######################################################################
#                                                                    #
# Read a list of servernames from the users home dir, login using    #
# ssh and cat /etc/motd or /var/run/motd.dynamic                     #
#                                                                    #
#                                                                    #
######################################################################


# ssh root@ubuntu server and print relevant parts of motd
function cat_ubuntu_motd {
  SERVER=$1
  printf "\n  ######################################################\n"
  printf "  #                 %-34s #\n" $SERVER
  MOTD=`ssh root@$SERVER "
    if [ -f /etc/motd ]; 
    then 
      cat /etc/motd 
    else
      cat /var/run/motd.dynamic
    fi"`
  UPDATE=$(printf "%s" "$MOTD" | grep "can be updated")
  SEC=$(printf "%s" "$MOTD" | grep "are security updates")
  NEW_RELEASE=$(printf "%s" "$MOTD" | grep "New release")
  REBOOT=$(printf "%s" "$MOTD" | grep "\*\*\*")

  echo "  #                                                    #"

  if [ -n "$UPDATE" ]; then
    printf "  #     %-42s     #\n" "$UPDATE"
  fi
  if [ -n "$SEC" ]; then
    printf "  #     %-42s     #\n" "$SEC"
  fi
  if [ -n "$REBOOT" ]; then
    printf "  #     %-42s     #\n" "$REBOOT"
  fi

  if [ -n "$NEW_RELEASE" ]; then
    printf "  # %-50s #\n" " "
    printf "  #    >>> %-35s <<<    #\n" "$NEW_RELEASE"
    printf "  # %-50s #\n" " "
  fi
 
  echo "  ######################################################"
}


# read the server names from config file in home dir

SERVERLIST="$HOME/.update_server_list"

IFS=$'\n' read -d '' -r -a lines < $SERVERLIST

LEN=${#lines[*]}
INDEX=0

while [ "$INDEX" -lt "$LEN" ]
do
  cat_ubuntu_motd ${lines[$INDEX]}

  let "INDEX += 1"
done
printf "\n"

