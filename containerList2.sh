#!/bin/bash
###Script by Skyler Davis. This script is intended to populate all the static mapped rack positions on a site and categorize them by site, container, and rack.
###This script will be used to provide input for other scripts. Example: If the site is supposed to be static mapped, and you run an fping using one of the files
###generated from this script as an input, any nonresponsive units are likely offline.


#declare integer type variables
typeset -i currentContainer currentRack currentMiner containerNum rackNum minerNum

#prompt user for site name and save it to siteName variable
echo "What is the name of your site?"
read siteName

#prompt user for number of containers and save it to containerNum variable
echo "How many containers do you have?"
read containerNum

echo "What is the first container?"
read currentContainer

#prompt user for number of racks per container and save it to containerNum variable
echo "How many racks are in each container?"
read rackNum

echo "What is the first rack?"
read currentRack

#prompt user for number of miners per rack and save it as minerNum variable
echo "How many miners are in each rack?"
read minerNum

#remove directory with same site name and recreate it. This will allow use to keep our container 
#lists organized by site and prevent any errors if the script tries to create and existing directory
rm -rf /home/skylerd/scripts/containerList/$siteName
mkdir /home/skylerd/scripts/containerList/$siteName

#while the value of variable currentContainer (starting at 1) is less than or equal to the value of
#containerNum (which is supplied earlier in the script by the script by the user), run the while loop.
#There are a total of 3 while loops, each one nested into the one before it. At the end of each iteration
#of the loop, add 1 to the value of currentContainer. This process is repeated in each loop.

#let currentContainer=1
while ((currentContainer<=containerNum)); do
	mkdir /home/skylerd/scripts/containerList/$siteName/C$currentContainer
	#let currentRack=1
	while ((currentRack<=rackNum)); do
		let currentMiner=1
		while ((currentMiner<=minerNum)); do
				#write each static mapped IP to a text file that is named after it's rack, 
				#in a directory named for it's container, in a directory named for it's site
				echo 10.$currentContainer$currentContainer.$currentRack.$currentMiner >> /home/skylerd/scripts/containerList/$siteName/$siteName
				echo 10.$currentContainer$currentContainer.$currentRack.$currentMiner >> /home/skylerd/scripts/containerList/$siteName/C$currentContainer/C$currentContainer
				echo 10.$currentContainer$currentContainer.$currentRack.$currentMiner >> /home/skylerd/scripts/containerList/$siteName/C$currentContainer/R$currentRack
				let currentMiner++
		done
		let currentRack++
	done
	let currentContainer++
done

