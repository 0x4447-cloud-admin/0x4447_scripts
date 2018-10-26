#!/bin/bash

#
#       1.      Set variable if OSFound equal to 0
#
OSFound=0

#
#       2.      Set Variable if user has savedfile (0 default)
#
SavedFile=0

#
#       3.      Get release info and grep for debian
#
cat /etc/*release* 2>/dev/null  | grep -i debian 2>/dev/null 1>/dev/null

#
#       4.      Check if debian was found in release file
#
if [ $? == 0 ]; then
  #
  #       5.      Since OS was found, set OSFound to 1
  #
  OSFound=1;
  #
  #       6.      Check for installation of  ffmpeg
  #
  dpkg -s ffmpeg 2>&1 | head -1 | grep "not installed" 1>/dev/null
  #
  #       7.      If ffmpeg is not installed, give ERROR,instructions, and exit script
  #
  if [ $? == 0 ]; then
    echo "ERROR: ffmpeg is not installed";
    echo "Please install using the following command:";
    echo "# apt-get install ffmpeg";
    exit 1;
  fi;
fi;

#
#       8.      Get release info and grep for linux releases (fedora, centos, redhat)
#
grep -Ei 'fedora|centos|redhat' /etc/*release* 1>/dev/null 2>&1

#
#       9.      Check if linux release was found in release file
#
if [ $? == 0 ]; then
  #
  #       10.      Since OS was found, set OSFound to 1
  #
  OSFound=1
  #
  #       11.      Check for installation of  ffmpeg
  #
  rpm -qa| grep ffmpeg 1>/dev/null 2>&1
  #
  #       12.      If ffmpeg is not installed, give ERROR,instructions, and exit script
  #
  if [ ! $? == 0 ]; then
    echo "ERROR: ffmpeg is not installed";
    echo "Please install using the following command:";
    echo "# yum install ffmpeg";
    echo "(If the above doesn't work, please check repositories)"
    exit 1;
  fi;
  #
  #       13.      End the check for OS
  #
fi;

#
#       14.      Check if any OS is found, if not ERROR and exit
#
if [ "$OSFound" == 0 ]; then
  echo "ERROR: OS not found";
  exit 1;
fi;


#
#       15.      Ask if user has saved information from previous use
#
echo "Do you have saved information from previous use of script? (Y/N) ";
#
#       16.      Take input
#
read -r SavedInfoAns;

#
#       17.      Check if there was any input, if not exit
#
if [ -z "$SavedInfoAns" ];
then
  echo "ERROR: No answer was entered";
  exit 1;
fi;

#
#       18.      Change the answer to Upper Case
#
SavedInfo=$(echo "$SavedInfoAns" | awk '{print toupper($0)}')

#
#       19.      Check if the answer was Y or Yes
#
if [ "$SavedInfo" == "Y" ] || [ "$SavedInfo" == "YES" ];
then
  #
  #       20.      Ask for path of saved file
  #
  echo "Please provide path of saved information file:";
  #
  #       21.      Take input
  #
  read -r SavedPath;
  #
  #       22.      Check if there was any input, if not request info
  #
  if [ -z "$SavedPath" ];
  then
    echo "ERROR: No PATH was entered";
    SavedFile=0
    #
    #       23.      Check if file exists, if not request info
    #
  elif [ ! -f "$SavedPath" ];
  then
    echo "ERROR: File does not exist"
    SavedFile=0
    #
    #       24.      If file exists set Varialbe to 1 for existence
    #
  else
    SavedFile=1
  fi;
fi;

#
#       25.      Check if SaveFile variable is 1 to pull data
#
if [ $SavedFile == "1" ];
then
  #
  #       26.      Get RTSPURL, YoutubeURL, and YoutubeKey from file
  #
  RTSPURL=$(grep RTSPURL "$SavedPath" | cut -d '=' -f2 );
  YoutubeURL=$(grep YoutubeURL "$SavedPath" | cut -d '=' -f2 );
  YoutubeKey=$(grep YoutubeKey "$SavedPath" | cut -d '=' -f2 );
  #
  #       27.      If any of the variables don't have value, request information
  #
  if [ -z "$RTSPURL" ] || [ -z "$YoutubeURL" ] || [ -z "$YoutubeKey" ];
  then
    echo "ERROR: File doesn't have the proper information...Continuing with request"
    SavedFile=0;
  fi;
fi;

#
#       28.      Check if SavedFile is 0, meaning data to be requested
#
if [ "$SavedFile" == "0" ];
then
  #
  #       29.      Request the address of camera
  #
  echo "Enter the address of camera: (rtsp://<user>:<password>@<address|IP>:<port#>/<rest of address>) ";
  #
  #       30.      Take input
  #
  read -r RTSPURL;
  
  #
  #       31.      Check if there was any input, if not exit
  #
  if [ -z "$RTSPURL" ];
  then
    echo "ERROR: No RTSP URL was entered";
    exit 1;
  fi;
  
  #
  #       32.      Request the stream address of youtube
  #
  echo "Enter the stream address of YouTube: (Example: rtmp://a.rtmp.youtube.com/live2) ";
  #
  #       33.      Take input
  #
  read -r YoutubeURL;
  
  #
  #       34.      Check if there was any input, if not exit
  #
  if [ -z "$YoutubeURL" ];
  then
    echo "ERROR: No YOUTUBE URL was entered";
    exit 1;
  fi;
  
  #
  #       35.      Request the stream key for youtube
  #
  echo "Enter the stream key for youtube: (####-####-####-####) ";
  #
  #       36.      Take input
  #
  read -r YoutubeKey;
  
  #
  #       37.      Check if there was any input, if not exit
  #
  if [ -z "$YoutubeKey" ];
  then
    echo "ERROR: No YOUTUBE KEY was entered";
    exit 1;
  fi;
  
  
  
  
  #
  #       38.      Ask if user wants to save information for future use
  #
  echo "Would you like to save information for future use? (Y/N) ";
  #
  #       39.      Take input
  #
  read -r SaveInfoAns;
  
  #
  #       40.      Check if there was any input, if yes make it upper case
  #
  if [ ! -z "$SaveInfoAns" ];
  then
    SaveInfo=$(echo "$SaveInfoAns" | awk '{print toupper($0)}')
    
  fi;
  
  #
  #       41.      Check if user entered Y or YES
  #
  if [ "$SaveInfo" == "Y" ] || [ "$SaveInfo" == "YES" ];
  then
    #
    #       42.      Ask user for path of where file is to be saved
    #
    echo "Please provide path of where to save information file: (<Dir>/<FileName>)";
    #
    #       43.      Take input
    #
    read -r SaveFile;
    #
    #       44.      Check if there was any input, if not continue without saving
    #
    if [ -z "$SaveFile" ];
    then
      echo "ERROR: No PATH was entered";
    else
      #
      #       45.      Create file if a path was entered
      #
      touch "$SaveFile"
    fi;
    #
    #       46.      Check if file exists, if not continue without saving
    #
    if [ ! -f "$SaveFile" ];
    then
      echo "ERROR: File cannot be saved to $SaveFile...Starting streaming"
      #
      #       47.      Input entries to file provided
      #
    else
      echo "RTSPURL=$RTSPURL" > "$SaveFile"
      echo "YoutubeURL=$YoutubeURL" >> "$SaveFile"
      echo "YoutubeKey=$YoutubeKey" >> "$SaveFile"
      echo "Information Saved to $SaveFile"
    fi;
  fi;
  #
  #       48.      End of if regarding saved file not existing
  #
fi;


#
#       49.      Assign variable the flags for the FFMPEG Input
#
FFMPEG_INPUT="-rtsp_transport tcp -thread_queue_size 512 -i ${RTSPURL}"
#
#       50.      Assign variable the flags for the FFMPEG Output
#
FFMPEG_OUTPUT="-r 25 -tune zerolatency -pix_fmt + -vsync 1 -async 1 -c:v copy -c:a aac -b:v 400k -bufsize 512k -f flv ${YoutubeURL}/${YoutubeKey}"
#
#       51.      Create variable that will run the whole command without any visible errors
#
COMMAND="ffmpeg -hide_banner -nostdin -nostats ${FFMPEG_INPUT} ${FFMPEG_OUTPUT}"

#
#       51.      Check if a stream is already running
#
ps -ef | grep -i ffmpeg | grep -v grep | grep -i rtmp 1>/dev/null 2>&1;

#
#       52.      Check if a stream is already running, if Yes then kill
#
if [ $? == "0" ]
then
  echo "An ffmpeg instance is running, please stop other instances before running this one ";
  exit 1;
fi;

#
#       53.      Inform User streaming has started
#
echo "Streaming started..."

#
#       54.      Run the COMMAND variable
#
eval "$COMMAND" &> /dev/null &
