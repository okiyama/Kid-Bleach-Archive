#!/bin/bash
#Script to archive teh kittehs(from kidbleach.com) written by Julian Jocque
#Union College 10/2011
#This is to be run daily by a cron job
#URL for where images are thanks to Andrew


date="$(date +%Y_%m_%d-%H-%M)"; #store current timestamp
if [ ! -f ./old.txt ]; #if we don't have an old.txt file it is first run
then
	echo "This is your first run! Let's make an old.txt file and then do our initial download."
	touch ./old.txt #on first run we need to make our old.txt file
	echo $date >> ./old.txt #then, since it is first run we just do a download without any diffing
	mkdir $date; #make timestamped folder
	cd $date; #go in it
	for i in {1..20}; do wget "http://kidbleach.com/images/`printf "%01d" $i`.jpg"; #wget through the numbered images
	done;
	cd ..; #go back where we were
	if [ ! -d ./main_archive ];
	    then
		mkdir ./main_archive #if we don't have a main archive we gotta make it
		cp -r ./$date ./main_archive
	else
	    cp -r ./$date ./main_archive #if we do, we just copy
	fi
return # we made an old.txt and did initial download and moved to main archive so we are done
fi

#so from here on out we know it is not the first run, let's do fancy things!

echo "Welcome back! Let's do a temporary download that we will check against your old folder and see if it is different."
mkdir $date; #make timestamped folder
cd $date; #go in it
for i in {1..20}; do wget "http://kidbleach.com/images/`printf "%01d" $i`.jpg"; #wget through the numbered images
done;
cd ..; #go back where we were

#so at this point we have our current folder with the name $date, we need to get a hold of what our old folder name is and store it
old="$(cat ./old.txt)"
if [`diff -q $old ./$date` != ""] #if it is quiet when we diff then there is no difference, else there is one
	then 
		echo "They aren't different, we're done here so let me kill that temporary folder for you." #since there is no difference we can get rid of the current folder
		rm -rf ./$date #which we do here
		return #nothing left to do since there is no diff
fi

echo "Hurray! They're different! Let's clean up that useless old temporary folder and store your current temporary folder to the main archive"
rm -rf ./$old #don't need this old shit
rm ./old.txt #since we have a difference!
touch old.txt #make a new old.txt
echo $date >> old.txt #and store our current date to there
# so now we have killed all the old stuff since it is old and bad
# we replaced it with new stuff!
# To archive that new stuff proper for the next time we add it to our main archive
if [ ! -d ./main_archive ];
then
	mkdir ./main_archive #if we don't have a main archive we gotta make it
	cp -r ./$date ./main_archive
else
	cp -r ./$date ./main_archive #if we do, we just copy
fi
echo "All done, you have your up to date archive in main_archive now!"
