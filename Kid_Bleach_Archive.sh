#!/bin/bash
# Script to archive the images on Kidbleach.com written by Julian Jocque
# Last modified: 9/23/2012
# This is to be run daily by a cron job
# Project page at https://github.com/okiyama/Kid-Bleach-Archive


date="$(date +%Y_%m_%d-%H-%M)"; #store current timestamp
if [ ! -f ./old.txt ]; #if we don't have an old.txt file it is first run
then
	echo "This is your first run! Let's make an old.txt file and then do our initial download."
	echo $date > ./old.txt #we make an old.txt with the date in it to signal to future runs it is not first run
	mkdir $date;
	cd $date;
	curl  -O 'http://kidbleach.com/public/images/[1-20].jpg' #Downloads all of the images on kidbleach
	cd ..;
	mkdir -p ./main_archive #Makes a main archive if we don't have one
	if [ ! -d ./main_archive ];
	    then
		echo "Unable to create the main archive! Exiting..."
		exit 1
	fi
	cp -r ./$date ./main_archive
exit 1 # we made an old.txt and did initial download and moved to main archive so we are done
fi

#so from here on out we know it is not the first run

echo "Welcome back! Let's do a temporary download that we will check against your old folder and see if it is different."
mkdir $date;
cd $date;
curl  -O 'http://kidbleach.com/public/images/[1-20].jpg' #Downloads all of the images on kidbleach
cd ..;

#so at this point we have our current folder with the name $date, we need to get a hold of what our old folder name is and store it
old="$(cat ./old.txt)"
if [`diff -q $old ./$date` != ""] #if it is quiet when we diff then there is no difference, else there is one
	then 
		echo "They aren't different, we're done here so let me kill that temporary folder for you." #since there is no difference we can get rid of the current folder
		rm -rf ./$date 
		exit 1 #nothing left to do since there is no diff
fi

echo "Hurray! They're different! Let's clean up that useless old temporary folder and store your current temporary folder to the main archive"
rm -rf ./$old #Can delete the temporary folder
echo $date > old.txt #makes a file with the current date in it
# so now we have killed all the old stuff and we replaced it with new stuff!
# To archive that new stuff proper for the next time we add it to our main archive
mkdir -p ./main_archive
if [ ! -d ./main_archive ];
then
	echo "Unable to create main archive folder! Exiting..."
	exit 1
fi
cp -r ./$date ./main_archive
echo "All done, you have your up to date archive in main_archive now!"
exit 1