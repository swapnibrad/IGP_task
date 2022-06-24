#!/bin/bash

if [ $# -ne 1 ]
then 
	echo "run the script"
	echo "$0 <start|stop|status|reboot|restart|install>"
	exit	
fi

echo  "reboot status start stop restart install" | grep -w $1 1>/dev/null 2>&1

if [ $? -ne 0 ]
then
	echo -e "enter correctly:\n start or stop or install or restart "
	exit
fi 

echo "mention the pkg name to be checked"
read pkg
echo "for $pkg" 

echo "we can :$1"

if [ "$1" == start ]
then
	echo "start service"
	systemctl start $pkg
		if [ $? -eq 0 ]
		then 
			echo "successfully started"
		else
			echo "failed to start"
		fi
fi

if [ "$1" == status ]
then
	which $pkg 1>&2 2>/dev/null
	if [ $? -eq 0 ]
		then
		echo "current status is :$(systemctl status $pkg |grep Active: | awk '{print $2}')"
		else
		echo "service $pkg is not install"
	fi
fi

if [ "$1" == stop ]
then 
	echo "we are stopping..."
	systemctl stop $pkg
		if [ $? -eq 0 ]
		then 
			echo "successfully stop"
		else
			echo "failed to stop"
		fi
	echo "stopped by user"
fi


if [ "$1" == restart ]
then 
	echo "restarting the service..."
	systemctl restart $pkg
		if [ $? -eq 0 ]
		then 
			echo "successfully restarted"
		else
			echo "failed to restart, check status"
		fi
	echo "restarted by user"
fi


if [ "$1" == install ]
then 
	echo "we are installing service..."
	yum install $pkg -y
		if [ $? -eq 0 ]
		then 
			echo -e "successfully install\n go with satrt or  status"
		else
			echo -e "failed to install\ncheck internet connection\ncheck repositeries\ncheck IAM image"
		fi
fi

if [ "$1" == reboot ]
then 
	echo "we are rebooting service...  can hold for few min.\n press "R""
	yum install $pkg -y
		if [ $? -eq 0 ]
		then 
			echo -e "successfully reboot\n go with satrt or  status"
		else
			echo -e "failed to reboot"
		fi
fi
