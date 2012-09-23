Kids Bleach Archiving Tool
==========================

**Purpose:** 
The way that kidbleach.com works is it calls an rss feed to decide what
pictures to display on the homepage. These images are typically kittens,
puppies and other such cute things. I realized however that when this rss feed
gets updated there is nowhere that those images get saved to. The previous
pictures are simply gone from access.
I thought it a noble cause to archive teh kittehs so I made this script.

<<<<<<< HEAD
**Dependencies:**  
Bash  
Wget  
>>>>>>> 1334041d68043975cfbb6143493b1cfee3e8f2ad

**Usage:**  
Save the script anywhere and keep it in this same folder.Run the script as
often as you like, most likely in a cronjob.

If you want to use this with a cronjob just run "crontab -e"  
Add a line that looks like this to the bottom of that file:  
0 12 * * * source "/path/to/Kid_Bleach_Archive.sh"  
That will run it daily at noon. For more info on cronjob, check the man page
by running "crontab --help"

<<<<<<< HEAD
**Functionality:**  
Checks if you have an old.txt file if not, it makes it.  
Grabs all the images from www.kidbleach.com  
If you had an old.txt file it checks them newly downloaded images against  
>>>>>>> 1334041d68043975cfbb6143493b1cfee3e8f2ad
the images you already have.
If this is a first run it saves them to main_archive.  
If it checks the images and finds no differences it deletes the recently  
downloaded images.
If there are differences it moves the new images to main_archive and then  
it deletes the now outdated folder and updates old.txt

As such, this can be run as much as you want and it will only use bandwidth
but it will never waste disk space.
