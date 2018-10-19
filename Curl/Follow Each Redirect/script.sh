#
#	1.	Request the name of site
#
echo "Enter the site name: (Press enter for https://demo.0x4447.com) ";
#
#	2.	Take input
#
read site;

#
#	3.	If no site entered, use default
#
if [ -z $site ];
then
	site="https://demo.0x4447.com"; 
fi;

#
#	4.	Empty Space
#
echo ""

#
#	5.	Array for the redirect URLs (starting with default)
#
newsite+=($site);
#
#	6.	Start counter 
#
counter=0
#
#	7.	Create tabs variable
#
tabs=""

#
#	8.	Loop through redirects
#
while true; 
do 
	#
	#	9.	Set nextLoc = to the redirected URL based on location line
	#
	nextLoc=$(curl -I ${newsite[counter]} 2>/dev/null | tr -d $'\r' | grep -i  ^"location:" | awk '{print $2}');
	
	#
	#	10.	If there is redirect, add URL to array
	#
	if [ ! -z $nextLoc ]; 
	then 
		newsite+=($nextLoc);
		nextLoc="";
		counter=$(( $counter + 1 ))
	else 
	#
	#	11.	Stop While Loop if no more redirects
	#
		break;
	fi; 
done;

#
#	12.	Separator
#
echo "=============================================================================";
	
#
#	13.	Loop through array and print hierarchy with URLs
#	
for i in $(seq 0 $(expr ${#newsite[@]} - 1));
do
	#
	#	14.	Add -- for hierarchy
	#
	for j in $(seq 0 $i);
	do
		tabs="${tabs}--"
	done;
		#
		#	15.	Print "--" and URL
		#
		echo "${tabs}${newsite[i]}"
done;

#
#	16.	Two empty lines
#
echo ""
echo ""

#
#	17.	Print URL and header info of the URL for each redirect
#
for i in $(seq 0 $(expr ${#newsite[@]} - 1));
do
	echo "=============================================================================";
	#
	#	18.	Print url of redirect
	#
	echo ${newsite[i]}
	echo "=============================================================================";
	#
	#	19. Print head info of redirect from URL
	#
	curl -I "${newsite[i]}"
	echo ""
done;

#
#	20.	Separator
#
echo "=============================================================================";
