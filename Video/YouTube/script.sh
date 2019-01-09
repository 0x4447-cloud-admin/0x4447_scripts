#!/bin/bash

#
#	1.	Set variable to main 0x4447 directory.
#
root_dir="$HOME/.0x4447"
#
#	1.	Create main directory to hold configuration information.
#
mkdir "$root_dir" 1>/dev/null 2>&1
#
#	1.	Change to that directory if possible, if not exit script.
#
cd "$root_dir" || exit 1
#
#	1.	Create variable with the directory of the youtube upload tool.
#
youtube_dir="$HOME/.0x4447/YouTube-Upload"
#
#	1.	Create directory for the JSON configuration files.
#
mkdir "$youtube_dir/JSON" 1>/dev/null 2>&1

#
#	1.	Run python command to check if python is installed.
#
python --version 1>/dev/null 2>&1

#
#	1.	If python is not installed exit script and provide error.
#
if [ $? != 0 ]; then
	echo "ERROR: python not insalled";
	echo "Please install python before proceeding";
	exit 1;
fi;

#
#	1.	Run pip command to check if it is installed.
#
pip 1>/dev/null 2>&1

#
#	1.	Check if pip is installed, if not install it.
#
if [ $? != 0 ]; then
	echo "pip not installed, installing...";
	#
	#	1.	Download the latest get-pip.py script and put in the youtube_dir.
	#
	wget https://bootstrap.pypa.io/get-pip.py -P "$youtube_dir" -q --show-progress
	
	#
	#	1.	Check if get-pip.py was downloaded successfully, if not exit.
	#
	if [ $? != 0 ]; then
		echo "ERROR: get-pip.py was not downloaded";
		echo "Please check if link has been changed from https://pip.pypa.io/en/latest/installing/";
		exit 1;
	fi;
	
	#
	#	1.	Run the get-pip.py script with python.
	#
	python "$youtube_dir/get-pip.py"
	
	#
	#	1.	Check if the installation was successful.
	#
	if [ $? != 0 ]; then
		echo "ERROR: pip could not be installed, check output";
		exit 1;
	fi;
	
fi;

#
#	1.	Run command to check if git is installed.
#
git --version 1>/dev/null 2>&1

#
#	1.	Check if git was installed, if not exit script.
#
if [ $? != 0 ]; then
	echo "ERROR: git not installed";
	echo "Please install git before proceeding";
	exit 1;
fi;

#
#	1.	Check if google-api-python-client is installed.
#
pip list | grep -i google-api-python-client 1>/dev/null 2>&1

#
#	1.	If google-api-python-client is not installed, install it.
#
if [ $? != 0 ]; then
	#
	#	1.	Check if the git has been cloned already.
	#
	if [ ! -f "$youtube_dir/Google-API/setup.py" ]; then
		#
		#	1.	If the repo has not been cloned, clone the repo.
		#
		git clone https://github.com/googleapis/google-api-python-client.git "$youtube_dir/Google-API"
		#
		#	2.	Check if the cloning was successful.
		#
		if [ $? != 0 ]; then
			echo "ERROR: Git repo could not be cloned";
			echo "Please check output and google-api-python-client repo";
			exit 1;
		fi;
	fi;
	
	#
	#	2.	Change directory to the cloned repo, if not possible exit script.
	#
	cd "$youtube_dir/Google-API" || exit 1
	#
	#	3.	Install the google-api-python-client utilizing the setup.py script.
	#
	python "$youtube_dir/Google-API/setup.py" install
	#
	#	4.	Check if installation was successful.
	#
	if [ $? != 0 ]; then
		echo "ERROR: Failed to install Google API";
		echo "Please check output";
		exit 1;
	fi;
	
	#
	#	5.	Upgrade to the latest version of the google-api if necessary.
	#
	pip install --upgrade google-api-python-client
	
	#
	#	6.	If pip upgrade is unsuccessful, exit script.
	#
	if [ $? != 0 ]; then
		echo "ERROR: Failed to upgrade google-api-python-client with pip";
		echo "Please check output";
		exit 1;
	fi;
fi;

#
#	1.	Check if oauth is installed.
#
pip list | grep oauth 1>/dev/null 2>&1

#
#	1.	If oauth is not installed, then install it.
#
if [ $? != 0 ]; then
	#
	#	1.	Install oauth2client.
	#
	pip install --upgrade oauth2client
	
	#
	#	2.	If installation fails, exit the script.
	#
	if [ $? != 0 ]; then
		echo "ERROR: Failed to install oauth2client";
		echo "Please check output";
		exit 1;
	fi;
	
fi;

#
#	1.	Check if youtube-upload is installed.
#
pip list | grep -i youtube-upload 1>/dev/null 2>&1

#
#	1.	If youtube-upload is not installed, proceed with installation.
#
if [ $? != 0 ]; then
	#
	#	1.	Check if youtube-upload repo has been cloned.
	#
	if [ ! -f "$youtube_dir/YT-Upload-Repo/setup.py" ]; then
		#
		#	1.	Clone the youtube-upload repo.
		#
		git clone https://github.com/tokland/youtube-upload.git "$youtube_dir/YT-Upload-Repo"
		#
		#	2.	If git clone fails, exit script and provide error.
		#
		if [ $? != 0 ]; then
			echo "ERROR: Git repo could not be cloned";
			echo "Please check output and youtube-upload repo";
			exit 1;
		fi;
	fi;
	#
	#	2.	Change directory to the YT-Upload-Repo, if not possible exit script.
	#
	cd "$youtube_dir/YT-Upload-Repo" || exit 1
	#
	#	3.	Run the setup.py script with python to install youtube-upload.
	#
	python "$youtube_dir/YT-Upload-Repo/setup.py" install
	
	#
	#	4.	If the setup.py script fails to install, exit script.
	#
	if [ $? != 0 ]; then
		echo "ERROR: Failed to install youtube-upload tool";
		echo "Please check output";
		exit 1;
	fi;
fi;

#
#	1.	Check if client-secrets.json file has been created.
#
if [ ! -f "$youtube_dir/JSON/client-secrets.json" ]; then
	
	#
	#	1.	Provide instructions on setting up OAuth2 Authentication.
	#
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

#
#	1.	Check the main.py script if the oauth2client is importing the File type.
#
grep "oauth2client" /usr/local/lib/python*/dist-packages/youtube_upload/main.py | grep "import" | grep "file" 1>/dev/null 2>&1

#
#	1.	If main.py is not importing the FILE type, make changes to main.py.
#
if [ $? != 0 ]; then
	#
	#	1.	Add the line to main.py and make a temp copy.
	#
	awk '/import oauth2client/ { print; print "from oauth2client import file"; next }1' /usr/local/lib/python*/dist-packages/youtube_upload/main.py > "$youtube_dir/.tmpfile"
	#
	#	2.	Move temp copy back to main.py as it contains the changes.
	#
	mv "$youtube_dir/.tmpfile" /usr/local/lib/python*/dist-packages/youtube_upload/main.py
fi;

#
#	1.	If youtube-upload-credentials.json doesn't exist, do initial setup.
#
if [ ! -f "$youtube_dir/JSON/youtube-upload-credentials.json" ]; then
	#
	#	1.	Run youtube-upload tool for initial Authorization of Application.
	#
	echo "##### Initial Authorization of Application ####";
	echo "Please make sure that you go to the link provided by script and copy and paste the Authorization code";
	youtube-upload --client-secrets="$youtube_dir/JSON/client-secrets.json" --title="test";
	
	#
	#	2.	Check if authorization was successful.
	#
	if [ $? != 0 ]; then
		echo "ERROR: YouTube was not authorized successfully";
		echo "Please check the output";
		exit 1;
	fi;
	
	#
	#	3.	Inform user of successful authorization.
	#
	echo "Authorization Successful";
	echo "You will not have to do this step in the future";
	
	#
	#	4.	Move the credentials to 0x4447 directory.
	#
	mv "$HOME/.youtube-upload-credentials.json" "$youtube_dir/JSON/youtube-upload-credentials.json";
	
fi;

#
#	1.	Request the full path of the video from user.
#
echo "Enter the full path of the video";
read -r video_path;
#
#	1.	Check if path was entered.
#
if [ -z "$video_path" ]; then
	
	echo "ERROR: No path was entered";
	echo "Exiting!"
	exit 1;
fi;

#
#	1.	Check if path exists.
#
if [ ! -f "$video_path" ]; then
	
	echo "ERROR: Video File does not exist";
	echo "Please check your path!"
	exit 1;
fi;
#
#	1.	Add double quotes to path.
#
video_path="\"${video_path}\""

#
#	1.	Request title of the video.
#
echo "Enter the Title of the video";
read -r title;
#
#	1.	Check if title was entered, if not exit.
#
if [ -z "$title" ]; then
	echo "ERROR: No Title was entered";
	echo "Exiting!"
	exit 1;
fi;

#
#	1.	Add formatting to title.
#
title="--title=\"${title}\""

#
#	1.	Request the privacy type for the video.
#
echo "Enter the privacy of the video (public | unlisted | private)";
read -r privacy;

#
#	1.	Check if privacy was entered and that it matches the options, if not exit.
#
if [ -z "$privacy" ] || [ "$privacy" != "public" ] && [ "$privacy" != "unlisted" ] && [ "$privacy" != "private" ]; then
	echo "ERROR: Privacy values is incorrect";
	echo "Exiting!"
	exit 1;
fi;

#
#	1.	Add formatting to privacy.
#
privacy="--privacy=\"${privacy}\""

#
#	1.	Request the description of the video.
#
echo "Enter the description of the video (Optional)";
read -r description;

#
#	1.	Check if description was entered, if so format it.
#
if [ ! -z "$description" ]; then
	description="--description=\"${description}\""
fi;

#
#	1.	Asks user if they want to input advanced information.
#
echo "Do you need to enter advanced information? (Yes, No)";
read -r advanced;

#
#	1.	Check if user wants to enter advanced information.
#
if [ "$advanced" == "Yes" ]; then
	
	#
	#	1.	Request the tags of the video from user.
	#
	echo "Enter the tags of the video (separated by commas: tag1, tag2,...)";
	read -r tags;
	#
	#	2.	If tags were entered, format it.
	#
	if [ ! -z "$tags" ]; then
		tags="--tags=\"${tags}\""
	fi;
	#
	#	3.	Request the license of the video from user.
	#
	echo "Enter the license of the video (enter 'youtube' or 'creativeCommon')";
	read -r license;
	#
	#	4.	If license was entered, check that it matches options and format it.
	#
	if [ ! -z "$license" ] || [ "$license" == "youtube" ] && [ "$license" == "creativeCommon" ]; then
		license="--license=\"${license}\""
	fi;
	
	#
	#	5.	Request the date video is to be published from user.
	#
	echo "Enter the date the video is to be published (YYYY-MM-DDThh:mm:ss.sZ)";
	read -r published_date;
	#
	#	6.	Check if publshed_date was entered, then format it.
	#
	if [ ! -z "$published_date" ]; then
		published_date="--publish-at=\"${published_date}\""
	fi;
	
	#
	#	7.	Request the recording date of the video from user.
	#
	echo "Enter the recording date of the video (YYYY-MM-DDThh:mm:ss.sZ)";
	read -r recording_date;
	#
	#	8.	Check if recording date was intered, then format it.
	#
	if [ ! -z "$recording_date" ]; then
		recording_date="--recording-date=\"${recording_date}\""
	fi;
	
	#
	#	9.	Request the language of the video from user.
	#
	echo "Enter the default video language of the video (ISO 639-1: en | fr | de | ...)";
	read -r default_video_language;
	#
	#	10.	Check if video language was entered, then format it.
	#
	if [ ! -z "$default_video_language" ]; then
		default_video_language="--default-language=\"${default_video_language}\""
	fi;
	
	#
	#	11.	Request the language of the audio from user.
	#
	echo "Enter the default audio language of the video (ISO 639-1: en | fr | de | ...)";
	read -r default_audio_language;
	#
	#	12.	Check if audio language was entered, then format it.
	#
	if [ ! -z "$default_audio_language" ]; then
		default_audio_language="--default-audio-language=\"${default_audio_language}\""
	fi;
	
	#
	#	13.	Request the thumbnail path for the video from user.
	#
	echo "Enter the path for thumbnail image of the video (JPEG or PNG)";
	read -r thumbnail_path;
	#
	#	14.	Check if a path was entered and that it exists, then format it.
	#
	if [ ! -z "$thumbnail_path" ] && [ -f "$thumbnail_path" ]; then
		thumbnail_path="--thumbnail=\"${thumbnail_path}\""
	fi;
	
	#
	#	15.	Request the playlist title of the video from user.
	#
	echo "Enter the playlist title of the video (if it does not exist, it will be created)";
	read -r playlist_title;
	#
	#	16.	Check if playlist title was entered, then format it.
	#
	if [ ! -z "$playlist_title" ]; then
		playlist_title="--playlist=\"${playlist_title}\""
	fi;
	
	#
	#	17.	Ask user if video is embeddable.
	#
	echo "Is the video Embeddable? (Yes, No)";
	read -r embeddable;
	
	#
	#	18.	Check if user answered Yes, then format it.
	#
	if [ "$embeddable" == "Yes" ]; then
		embeddable="--embeddable=EMBEDDABLE"
	fi;
	
	#
	#	19.	If user said not, set embeddable variable empty.
	#
	if [ "$embeddable" == "no" ]; then
		embeddable=""
	fi;
	
fi;

#
#	1.	Create a string variable with the command to upload.
#
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

#
#	1.	Run the command from the variable.
#
eval "$youtube_upload_cmd";