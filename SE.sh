#!/bin/bash

# Q3MAP4 Script-Engine 3/28/2020
# ******************************
# THIS FILE IS LINE-COUNT SENSITIVE
#
# This is a table of abbreviations used:
#
# Executable Path
# Standard Flags
# Thread Count
# Build Options
# Map Data

if [ "$1" = defaults ]
then
	echo "Restoring Default Configuration Values"
	sed -i "29s#.*#EP='/data/quake3/q3map4.x86_64'#" SE.sh
	sed -i "30s#.*#SF='-v -game quake -fs_basepath "/data/quake" -fs_game baseq3'#" SE.sh
	sed -i "31s#.*#TC='-threads 8'#" SE.sh
	sed -i "32s#.*#BObsp='-meta -patchmeta'#" SE.sh
	sed -i "33s#.*#BOfastlight='-light -fast'#" SE.sh
	sed -i "34s#.*#BOlight='-light -bounce 12 -bouncegrid -fastgrid -filter'#" SE.sh
	sed -i "35s#.*#BOvis='-vis -saveprt'#" SE.sh
	sed -i "36s#.*#MD='/data/quake3/baseq3/maps/fedo.map'#" SE.sh
exit
fi

EP='/data/quake3/q3map4.x86_64'
SF='-v -game quake -fs_basepath /data/quake -fs_game baseq3'
TC='-threads 8'
BObsp='-meta -patchmeta'
BOfastlight='-light -fast'
BOlight='-light -bounce 12 -bouncegrid -fastgrid -filter'
BOvis='-vis -saveprt'
MD='/data/quake3/baseq3/maps/fedo.map'

# *****************************************
# LINE-COUNTS NON-SENSITIVE PAST THIS POINT
# *****************************************

if [ -n "$1" ]
then
	case $1 in

	clean)
	echo "Removing Scripts"
	rm bsp.q3x
	rm fast-light.q3x
	rm light.q3x
	rm vis.q3x
		if [ -e help.txt ]
		then
		rm help.txt
		fi
	exit
	;;

	EP)
	echo "Updating Executable Path"
	UEP=$2
	sed -i '29s/.*/EP='$UEP'/' SE.sh
	exit
	;;

	SF)
	echo "Updating Standard Flags"
	USF=$2
	sed -i '30s/.*/SF='$USF'/' SE.sh
	exit
	;;

	TC)
	echo "Updating Thread Count"
	UTC=$2
	sed -i '31s/.*/TC='$UTC'/' SE.sh
	exit
	;;

	BObsp)
	echo "Updating Build Options - BSP"
	UBObsp=$2
	sed -i '32s/.*/BObsp='$UBObsp'/' SE.sh
	exit
	;;

	BOfastlight)
	echo "Updating Build Options - Fast Light"
	UBOfastlight=$2
	sed -i '33s/.*/BOfastlight='$UBOfastlight'/' SE.sh
	exit
	;;

	BOlight)
	echo "Updating Build Options - Light"
	UBOlight=$2
	sed -i '34s/.*/BOlight='$UBOlight'/' SE.sh
	exit
	;;

	BOvis)
	echo "Updating Build Options - Vis"
	UBOvis=$2
	sed -i '35s/.*/BOvis='$UBOvis'/' SE.sh
	exit
	;;

	MD)
	echo "Updating Map Data"
	UMD=$2
	sed -i '36s/.*/MD='$UMD'/' SE.sh
	exit
	;;

	help)
	echo "********************************************************"
	echo "*           Q3MAP4 Script Engine 3/28/2020             *"
	echo "********************************************************"
	echo "                                                        "
	echo "This will generate a suite of Q3MAP4 compilation scripts"
	echo "based on the internal configuration data.  When you     "
	echo "modify the options below, this script gets modified to  "
	echo "store the desired changes.                              "
	echo "                                                        "
	echo "Below are the toggable options, invoked as shown:       "
	echo "                                                        "
	echo " SE.sh EP /data/quake3/q3map4.x86_64                    "
	echo "                                                        "
	echo "EP - Executable Path                                    "
	echo "SF - Standard Flags                                     "
	echo "TC - Thread Count                                       "
	echo "BObsp - Build Options - BSP                             "
	echo "BOfastlight - Build Options - Fast Light                "
	echo "BOlight - Build Options - Light                         "
	echo "BOvis - Build Options - Vis                             "
	echo "MD - Map Data                                           "
	echo "                                                        "
	echo "help - This help output                                 "
	echo "q3map4-help - Write Q3MAP4 Compiler Help to a file      "
	echo "defaults - resets the configurable options              "
	echo "                                                        "
	echo "********************************************************"
	exit
	;;

	q3map4-help)
	echo "Writing Help"
	$EP -help >> help.txt
	exit
	;;

	*)
	echo "Unrecognized input"
	exit
	;;
	esac
else
echo "Generating Scripts in $(pwd) "
echo "$EP $SF $TC $BObsp $MD" >> bsp.q3x
echo "$EP $SF $TC $BOfastlight $MD" >> fast-light.q3x
echo "$EP $SF $TC $BOlight $MD" >> light.q3x
echo "$EP $SF $TC $BOvis $MD" >> vis.q3x
chmod +x bsp.q3x
chmod +x fast-light.q3x
chmod +x light.q3x
chmod +x vis.q3x
fi
