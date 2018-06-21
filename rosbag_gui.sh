#/bin/bash

#constants
GREEN='\033[0;32m'
fin=0 ## initially set finish to zero since no data has been recorded
DIR="$HOME/rosbag-data"
today=`date +%Y-%m-%d:%H:%M:%S`


function clean_up {

	if [ "$fin" -eq 	0 ] #check if file info was finished processing, if not then exit immediately
		then
			echo -e "\n SIGTERM  initiated before file info was complete, exiting"

			exit
	fi

#else user interrupted 
echo -e "\n ROSBAG finished recording"

#add your post processing scripts after SIGTERM (crtl+c) here:

#EX: echo -e "I love ROS!"


}

trap clean_up SIGHUP SIGINT SIGTERM

function get_topics {

mapfile -t  lines < <(rostopic list)
topiclist=$(zenity --list --checklist --title="Select Topics for Recording" --column="select" --column="topic" ${lines[@]} 2>/dev/null) #map stderror to null because zenity produces useless GTK errors.

topiclist=${topiclist[@]}
topiclist=${topiclist//[|]// }

}

function fileinfo {
		filename=$(zenity --entry --text "Enter in file name for this bag" 2>/dev/null) #map stderror to null because zenity produces useless GTK errors.
		comment=$(zenity --entry --text "Enter comment for this bag" 2>/dev/null) #map stderror to null because zenity produces useless GTK errors.
		get_topics
		echo "Topics for recording: " $topiclist
		cont=1 #continue (1 = no, 0 = yes)
		zenity --question --text="Proceed with Data Recording?\n Filename:${filename} \n Topics: ${topiclist}" 2>/dev/null #map stderror to null because zenity produces useless GTK errors.
		cont=$? #zenity stores question output in var $?	

			if [ $cont -eq 0 ]
				then
					fin=1
					if [ ! -d "$DIR" ]
						then
						echo "Directory " $DIR "not found, creating"
						mkdir $DIR
					fi
					echo "Creating Directory " $DIR"/"$today
					mkdir $DIR"/"$today
					echo "$comment" >> $DIR"/"$today"/readme.txt"
			fi
}


fileinfo #run once

# check to make sure user wants to proceed
		while [[ $cont != 0  ]] #check if file info is correct
		do
		fin=0	#set finish = to zero in case of sigterm
		fileinfo
		done
fin=1 # file info complete so now sigterm will run postprocess scripts

echo -e "${GREEN}Recording Topics: "$topiclist
rosbag record $topiclist -O $DIR"/"$today"/"$filename

#Author
#Amir Darwesh
#amirdarwesh@gmail.com

#License
#MIT
