#!/bin/bash

#
#	1.	Create default directory and Set variable with the path of Saved credentials file.
#
mkdir "$HOME/.0x4447" 1>/dev/null 2>&1
SavedPath="$HOME/.0x4447/rtp_to_youtube"

#
#	2.	Set Variable ContinueScript to initial value of 0.
#
ContinueScript=0


#
#	3.	Check if ffmpeg binary is installed.
#
command -v ffmpeg 1>/dev/null 2>&1;

#
#	4.	If ffmpeg doesn't exist, show error and exit script with exit
#       value of 1.
#
if [ $? == 1 ]; then
    echo "ERROR: ffmpeg does not seem installed";
    echo "Please refer to your OS manual to install ffmpeg package";
    echo "Exiting!"
    exit 1;
fi;

#
#	5.	Check if the Saved credentials file exists.
#
if [ -f "$SavedPath" ]; then
    
    #
    #	1.	Get RTSPURL, YoutubeURL, and YoutubeKey from file.
    #
    RTSPURL=$(grep RTSPURL "$SavedPath" | cut -d '=' -f2 );
    YoutubeURL=$(grep YoutubeURL "$SavedPath" | cut -d '=' -f2 );
    YoutubeKey=$(grep YoutubeKey "$SavedPath" | cut -d '=' -f2 );
    
    #
    #	2.	If any of the variables don't have value, request information.
    #
    if [ -z "$RTSPURL" ] || [ -z "$YoutubeURL" ] || [ -z "$YoutubeKey" ]; then
        
        echo "ERROR: File doesn't have the proper information...Continuing with request"
        
        #
        #	1.	Set ContinueScript to continue with requesting the information
        #       from user.
        #
        ContinueScript=1;
        
    fi;
    
fi;

#
#	6.	Check if Saved credentials doesn't exist or if it didn't have proper
#       information.
#
if [ ! -f "$SavedPath" ] || [ $ContinueScript == "1" ]; then
    
    #
    #	1.	Request the address of camera.
    #
    echo "Enter the address of camera: (rtsp://<user>:<password>@<address|IP>:<port#>/<rest of address>) ";
    
    #
    #	2.	Take input.
    #
    read -r RTSPURL;
    
    #
    #	3.	Check if there was any input, if not exit.
    #
    if [ -z "$RTSPURL" ]; then
        
        echo "ERROR: No RTSP URL was entered";
        echo "Exiting!"
        exit 1;
        
    fi;
    
    #
    #	4.	Request the stream address of youtube.
    #
    echo "Enter the stream address of YouTube: (Example: rtmp://a.rtmp.youtube.com/live2) ";
    
    #
    #	5.	Take input.
    #
    read -r YoutubeURL;
    
    #
    #	6.	Check if there was any input, if not exit.
    #
    if [ -z "$YoutubeURL" ]; then
        
        echo "ERROR: No YOUTUBE URL was entered";
        echo "Exiting!"
        exit 1;
        
    fi;
    
    #
    #	7.	Request the stream key for youtube.
    #
    echo "Enter the stream key for youtube: (####-####-####-####) ";
    
    #
    #	8.	Take input.
    #
    read -r YoutubeKey;
    
    #
    #	9.	Check if there was any input, if not exit.
    #
    if [ -z "$YoutubeKey" ]; then
        
        echo "ERROR: No YOUTUBE KEY was entered";
        echo "Exiting!"
        exit 1;
        
    fi;
    
    #
    #	10.	Create empty file in the directory provided in SavedPath and set ContinueScript to 1.
    #
    touch "$SavedPath"
    
    #
    #	11.	Make sure that ContinueScript is set to 1.
    #
    ContinueScript=1;
    
    #
    #	12.	Check if file was created.
    #
    if [ ! -f "$SavedPath" ]; then
        
        echo "ERROR: File cannot be saved to $SavedPath...Starting streaming"
        
        #
        #	1.	Set ContinueScript back to 0 so it doesn't try to input the
        #       data.
        #
        ContinueScript=0;
    fi;
    
    #
    #	13.	Input entries to file provided.
    #
    if [ $ContinueScript == "1" ]; then
        echo "RTSPURL=$RTSPURL" > "$SavedPath"
        echo "YoutubeURL=$YoutubeURL" >> "$SavedPath"
        echo "YoutubeKey=$YoutubeKey" >> "$SavedPath"
        echo "Information Saved to $SavedPath"
    fi;
    
fi;

#
#	7.	Assign variable the flags for the FFMPEG Input.
#
FFMPEG_INPUT="-rtsp_transport tcp -thread_queue_size 512 -i ${RTSPURL}"

#
#	8.	Assign variable the flags for the FFMPEG Output.
#
FFMPEG_OUTPUT="-r 25 -tune zerolatency -pix_fmt + -vsync 1 -async 1 -c:v copy -c:a aac -b:v 400k -bufsize 512k -f flv ${YoutubeURL}/${YoutubeKey}"

#
#	9.	Create variable that will run the whole command without any visible
#       errors.
#
COMMAND="ffmpeg -hide_banner -nostdin -nostats ${FFMPEG_INPUT} ${FFMPEG_OUTPUT}"

#
#	10.	Check if a stream is already running.
#
pgrep ffmpeg 1>/dev/null 2>&1;

#
#	11.	Check if a stream is already running, if Yes then exit script with
#       value 1.
#
if [ $? == "0" ]; then
    
    echo "ERROR: An ffmpeg instance is running, please stop other instances before running this one ";
    echo "Exiting!"
    exit 1;
    
fi;

#
#	12.	Inform User streaming has started.
#
echo "Streaming started..."

#
#	13.	Run the COMMAND variable.
#
eval "$COMMAND"
