#!/bin/bash

root_dir="$HOME/.0x4447"
mkdir "$root_dir" 1>/dev/null 2>&1
cd "$root_dir" || exit 1
youtube_dir="$HOME/.0x4447/YouTube-Upload"
mkdir "$youtube_dir/JSON" 1>/dev/null 2>&1

python --version 1>/dev/null 2>&1

if [ $? != 0 ]; then
    echo "ERROR: python not insalled";
    echo "Please install python before proceeding";
    exit 1;
fi;

pip 1>/dev/null 2>&1

if [ $? != 0 ]; then
    echo "pip not installed, installing...";
    
    wget https://bootstrap.pypa.io/get-pip.py -P "$youtube_dir" -q --show-progress
    
    if [ $? != 0 ]; then
        echo "ERROR: get-pip.py was not downloaded";
        echo "Please check if link has been changed from https://pip.pypa.io/en/latest/installing/";
        exit 1;
    fi;
    
    python "$youtube_dir/get-pip.py"
    
    if [ $? != 0 ]; then
        echo "ERROR: pip could not be installed, check output";
        exit 1;
    fi;
    
fi;

git --version 1>/dev/null 2>&1

if [ $? != 0 ]; then
    echo "ERROR: git not installed";
    echo "Please install git before proceeding";
    exit 1;
fi;

pip list | grep -i google-api-python-client 1>/dev/null 2>&1

if [ $? != 0 ]; then
    
    if [ ! -f "$youtube_dir/Google-API/setup.py" ]; then
        git clone https://github.com/googleapis/google-api-python-client.git "$youtube_dir/Google-API"
        if [ $? != 0 ]; then
            echo "ERROR: Git repo could not be cloned";
            echo "Please check output and google-api-python-client repo";
            exit 1;
        fi;
        
    fi;
    
    cd "$youtube_dir/Google-API" || exit 1
    python "$youtube_dir/Google-API/setup.py" install
    
    if [ $? != 0 ]; then
        echo "ERROR: Failed to install Google API";
        echo "Please check output";
        exit 1;
    fi;
    
    pip install --upgrade google-api-python-client
    
    if [ $? != 0 ]; then
        echo "ERROR: Failed to upgrade google-api-python-client with pip";
        echo "Please check output";
        exit 1;
    fi;
fi;

pip list | grep oauth 1>/dev/null 2>&1

if [ $? != 0 ]; then
    pip install --upgrade oauth2client
    
    if [ $? != 0 ]; then
        echo "ERROR: Failed to install oauth2client";
        echo "Please check output";
        exit 1;
    fi;
    
fi;

pip list | grep -i youtube-upload 1>/dev/null 2>&1

if [ $? != 0 ]; then
    if [ ! -f "$youtube_dir/YT-Upload-Repo/setup.py" ]; then
        git clone https://github.com/tokland/youtube-upload.git "$youtube_dir/YT-Upload-Repo"
        if [ $? != 0 ]; then
            echo "ERROR: Git repo could not be cloned";
            echo "Please check output and youtube-upload repo";
            exit 1;
        fi;
    fi;
    
    cd "$youtube_dir/YT-Upload-Repo" || exit 1
    python "$youtube_dir/YT-Upload-Repo/setup.py" install
    
    if [ $? != 0 ]; then
        echo "ERROR: Failed to install youtube-upload tool";
        echo "Please check output";
        exit 1;
    fi;
fi;

if [ ! -f "$youtube_dir/JSON/client-secrets.json" ]; then
    
    echo "";
    echo "";
    echo "################### INSTRUCTIONS FOR SETTING UP OAuth2 Authentication ###################";
    echo "Please go to https://console.developers.google.com/project";
    echo "Click CREATE PROJECT";
    echo "Set Project Name to whatever you like";
    echo "Leave PROJECT ID with the default Value";
    echo "Click Create button";
    echo "Wait for the Project Creation to finish under activities";
    echo "Click \"Go to APIs overview\"";
    echo "Make sure that you are on the correct project On the top left";
    echo "Click \"ENABLE APIS AND SERVICES\" on top";
    echo "Search for \"YouTube Data API\"";
    echo "Click \"YouTube Data API V3\" (version might differ) ";
    echo "Click ENABLE";
    echo "Click \"Credentials\"";
    echo "Click \"Credentials in APIs & Services\" to view all credentials";
    echo "Click \"OAuth consent screen\"";
    echo "Insert an \"Application name\"";
    echo "Select \"Support email\"";
    echo "(Optional) You may fill in other information if you wish";
    echo "Click Save at the bottom";
    echo "Click \"Create credentials\"";
    echo "Select \"OAuth client ID\"";
    echo "Select Other";
    echo "Set a name for other Application type";
    echo "Click OK";
    echo "Download JSON on the right of the credentials";
    echo "Copy the data inside the JSON file to ~/.0x4447/YouTube-Upload/JSON/client-secrets.json";
    echo "#########################################################################################";
    echo "";
    read -n 1 -s -r -p "Press any key when you've completed the steps";
    echo "";
    echo "";
    
fi;


grep "oauth2client" /usr/local/lib/python*/dist-packages/youtube_upload/main.py | grep "import" | grep "file" 1>/dev/null 2>&1

if [ $? != 0 ]; then
    awk '/import oauth2client/ { print; print "from oauth2client import file"; next }1' /usr/local/lib/python*/dist-packages/youtube_upload/main.py > "$youtube_dir/.tmpfile"
    mv "$youtube_dir/.tmpfile" /usr/local/lib/python*/dist-packages/youtube_upload/main.py
fi;

if [ ! -f "$youtube_dir/JSON/youtube-upload-credentials.json" ]; then
    
    echo "##### Initial Authorization of Application ####";
    echo "Please make sure that you go to the link provided by script and copy and paste the Authorization code";
    youtube-upload --client-secrets="$youtube_dir/JSON/client-secrets.json" --title="test";
    
    if [ $? != 0 ]; then
        echo "ERROR: YouTube was not authorized successfully";
        echo "Please check the output";
    fi;
    
    echo "Authorization Successful";
    echo "You will not have to do this step in the future";
    
    mv "$HOME/.youtube-upload-credentials.json" "$youtube_dir/JSON/youtube-upload-credentials.json";
    
fi;

echo "Enter the full path of the video";
read -r video_path;
if [ -z "$video_path" ]; then
    
    echo "ERROR: No path was entered";
    echo "Exiting!"
    exit 1;
    
fi;

if [ ! -f "$video_path" ]; then
    
    echo "ERROR: Video File does not exist";
    echo "Please check your path!"
    exit 1;
    
fi;
video_path="\"${video_path}\""

echo "Enter the Title of the video";
read -r title;
if [ -z "$title" ]; then
    
    echo "ERROR: No Title was entered";
    echo "Exiting!"
    exit 1;

fi;
title="--title=\"${title}\""

echo "Enter the privacy of the video (public | unlisted | private)";
read -r privacy;
if [ -z "$privacy" ] || [ "$privacy" != "public" ] && [ "$privacy" != "unlisted" ] && [ "$privacy" != "private" ]; then
    
    echo "ERROR: Privacy values is incorrect";
    echo "Exiting!"
    exit 1;
    
fi;
privacy="--privacy=\"${privacy}\""

echo "Enter the description of the video";
read -r description;

if [ ! -z "$description" ]; then
description="--description=\"${description}\""
fi;

echo "Do you need to enter advanced information? (Yes, No)";
read -r advanced;

if [ "$advanced" == "Yes" ]; then
    echo "Enter the tags of the video (separated by commas: tag1, tag2,...)";
    read -r tags;
    if [ ! -z "$tags" ]; then
    tags="--tags=\"${tags}\""
    fi;
    
    echo "Enter the license of the video (enter 'youtube' or 'creativeCommon')";
    read -r license;
    if [ ! -z "$license" ] || [ "$license" != "youtube" ] && [ "$license" != "creativeCommon" ]; then
    license="--license=\"${license}\""
    fi;

    echo "Enter the date the video is to be published (YYYY-MM-DDThh:mm:ss.sZ)";
    read -r published_date;
    if [ ! -z "$published_date" ]; then
    published_date="--publish-at=\"${published_date}\""
    fi;

    echo "Enter the recording date of the video (YYYY-MM-DDThh:mm:ss.sZ)";
    read -r recording_date;
    if [ ! -z "$recording_date" ]; then
    recording_date="--recording-date=\"${recording_date}\""
    fi;

    echo "Enter the default video language of the video (ISO 639-1: en | fr | de | ...)";
    read -r default_video_language;
    if [ ! -z "$default_video_language" ]; then
    default_video_language="--default-language=\"${default_video_language}\""
    fi;

    echo "Enter the default audio language of the video (ISO 639-1: en | fr | de | ...)";
    read -r default_audio_language;
    if [ ! -z "$default_audio_language" ]; then
    default_audio_language="--default-audio-language=\"${default_audio_language}\""
    fi;

    echo "Enter the path for thumbnail image of the video (JPEG or PNG)";
    read -r thumbnail_path;
    if [ ! -z "$thumbnail_path" ]; then
    thumbnail_path="--thumbnail=\"${thumbnail_path}\""
    fi;
    
    echo "Enter the playlist title of the video (if it does not exist, it will be created)";
    read -r playlist_title;
    if [ ! -z "$playlist_title" ]; then
    playlist_title="--playlist=\"${playlist_title}\""
    fi;
    
    echo "Is the video Embeddable? (Yes, No)";
    read -r embeddable;
    
    if [ "$embeddable" == "Yes" ]; then
        embeddable="--embeddable=EMBEDDABLE"
    fi;
    
    if [ "$embeddable" == "no" ]; then
        embeddable=""
    fi;
    
fi;

youtube_upload_cmd="youtube-upload \
--client-secrets=\"$youtube_dir/JSON/client-secrets.json\" \
--credentials-file=\"$youtube_dir/JSON/youtube-upload-credentials.json\" \
$title \
$privacy \
$description \
$tags \
$license \
$published_date \
$recording_date \
$default_video_language \
$default_audio_language \
$thumbnail_path \
$playlist_title \
$embeddable \
$video_path";

eval "$youtube_upload_cmd";