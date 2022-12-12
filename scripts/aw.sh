#!/bin/bash
# Author:  Marco Kroemer
# Creation date: 30.11.2018
# Revision date: 11.12.2022
# Purpose of the script: 
# With the help of this script it is possible to read, create and overwrite userInput. It is also possible to add texts. 
# The script is supposed to respond to the user's input in a particularly user-friendly way.



function printVerboseOutput()
{
	if [ $verboseMode = true ] ; then
		echo -e "$1"
	fi

}


function checkUserInputExists()
{	
	local userInput="$*"
	result=""
	printVerboseOutput "Überprüfung ob Daten eingeben wurden"	
	if [ "${userInput[*]}" == "" ] ; then
		result=false
		echo -e "Es wurden keine Daten übergeben."
 	else 
		result=true		
	fi

}


function checkAndCorrectFiles()
{
	local userInput="$*"

	result=false
	printVerboseOutput "Überprüfung ob die Datei/n vorhanden ist/sind \"${userInput[*]}\"."
	local count=0		
	for (( count ; count<${#userInput[*]} ; count++)) ; do			
		while [ $result = false ] ; do 
			checkFileExists  ${userInput[count]}
			if [ $result = true ] ; then 
				printVerboseOutput "Datei gefunden \"${userInput[count]}\"."
				files[fileCount]=${userInput[count]} 	
				fileCount=fileCount+1
				result=true			
			else
				readFileName
			 	userInput[count]=$result
				result=false
			fi
		done 
	done
}

function checkFileExists()
{
	local fileName="$1"
	result=""	
	printVerboseOutput "Überprüfung ob die Datei vorhanden ist \"$fileName\"."
	if [ ! -f ${fileName} ] ; then 		
			echo "Die Datei \"${fileName}\" exsistiert nicht." 
			result=false
	else 
	 	result=true	
	fi
}



function readFileName() {
	result=""
	printVerboseOutput "Dateiname wird eingelesen"
	while [ "$result" == "" ] ; do
			read -p "Geben Sie Bitte den Dateinamen ein! >" result 	
	done	
}

function readTextAndFileName()
{	 
	
	printVerboseOutput "Inhalt und Dateiname werden eingelesen"
	echo -e "Es fehlen Parameter. Ein Dateiname ist zwingend erforderlich, der Text ist optional"
	read -p "Geben Sie Ihren Text ein. (optional)  >" userInput[0] 	  
	readFileName 1

}				
	



function readFiles()
{			
	checkAndCorrectFiles "$*"
	printVerboseOutput "Lesen der Datei/n \"${files[*]}\"."
	local count=0
	for ((count ; count<${#files[*]} ; count++)) ; do
		echo -e "---------------------------------------"
		echo -e "Datei: ${files[count]}"
		printVerboseOutput "Größe in Bytes: $(stat -c %s ${files[count]})"
		echo -e "Inhalt:\n"
		cat ${files[count]}
	done 
}

function writeFile()
{
	
	# the array starts at position 0
	local lenght=$((${#userInput[*]}-1)) 	

	printVerboseOutput "Letzter Parameter wird für den Dateinamen verwendet:\"${userInput[lenght]}\"." 

	local fileName=${userInput[lenght]}
	unset userInput[lenght]
	
	printVerboseOutput "überprüfung ob die Datei bereits vorhanden ist.."

	if [ -f $fileName ] ; then 
	
		echo "Es exsistiert bereits eine Datei mit diesem Namen, soll diese überschrieben werden oder sollen die Daten angefügt werden?"
		read -p "Überschreiben (w) ; Anfügen (a) ; Alle anderen Tasten beenden das Skript >" eingabe

		if [ $eingabe == "a" ] ; then
			
			printVerboseOutput "Text wird an die Datei angehängt"
			printVerboseOutput "Länge vor dem Vorgang: $(stat -c %s $fileName)"
			echo ${userInput[*]} >> $fileName
			printVerboseOutput "Länge nach dem Vorgang: $(stat -c %s $fileName)"

		elif [ $eingabe == "w" ] ; then
			
			printVerboseOutput "Datei wird überschrieben und der Text hineingeschrieben"

			echo ${userInput[*]} > $fileName
			printVerboseOutput "Länge nach dem Vorgang: $(stat -c %s $fileName)"
		else 

			echo "Skript wird beendet"
			exit

		fi
	else
		
		printVerboseOutput "Datei wird erstellt und der Text hineingeschrieben"
		
			
		echo ${userInput[*]} > $fileName
		printVerboseOutput "Länge nach dem Vorgang: $(stat -c %s $fileName)"
	fi

}

funkverlaengern()
{

	fileName=""
	
	printVerboseOutput "Letzter Parameter wird für den Dateinamen verwendet:\"${userInput[${#userInput[*]}-1]}\"." 

	fileName=${userInput[${#userInput[*]}-1]}
	unset userInput[${#userInput[*]}-1]
	printVerboseOutput "überprüfung ob die Datei bereits vorhanden ist.."

	if [ -f $fileName ] ; then 
	
		printVerboseOutput "Text wird an die Datei angehängt"
	
		printVerboseOutput "Länge vor dem Vorgang: $(stat -c %s $fileName)"
		echo ${userInput[*]} >> $fileName
		
		printVerboseOutput "Länge nach dem Vorgang: $(stat -c %s $fileName)"
	else 	
		echo "Es exsistiert keine Datei mit diesem Namen, soll die Datei neuerstellt werden?"
		read -p "Erstellen (w) ; Alle anderen Tasten beenden das Skript >" eingabe

		if [ $eingabe == "w" ] ; then
			printVerboseOutput "Datei wird erstellt und der Text hineingeschrieben"		
			echo ${userInput[*]} > $fileName
			printVerboseOutput "Länge nach dem Vorgang: $(stat -c %s $fileName)"
		else 
			echo "Skript wird beendet"
			exit	

		fi
		
	fi

}

function showHelp()
{
echo -e "
	Mit diesem Skript können Dateien gelesen, erstellt und überschrieben werden.
	Es ist auch möglich Text anzufügen.
	Die folgenden Parameter sind zu gelassen:

	-r  --Alle anderen über gebenen Paramater werden als Dateinamen gesehen und ihr Inhalt wird ausgegeben\n
	-w  --Der letzte Parameter wird als Dateiname angesehen, alle anderen Parameter als Inhalt der Datei\n
	-a  --Der letzte Parameter wird als Dateiname angesehen, alle anderen Parameter werden an den Inhalt angefügt\n
	-v  --Gibt Informationen zur Tätigkeit des Skripts aus, eine von den oberen Parametern muss auch angeben sein (-vr -rv ist auch möglich)\n
	-h  --Zeigt diese Hilfe an\n

	Beispiele:
	aw.sh -r test.txt hallo.txt #Gibt den Inhalt der beiden Dateien aus
       	aw.sh -wv Dies ist ein Beispiel beispiel.txt #Erstellt eine Datei Names beispiel.txt mit dem Inhalt \"Dies ist ein Beispiel\",
		  Die Bearbeitungsschritte des Skriptes werden ebenso ausgegeben	  
	"
}



# Available modes are disabled by default
verboseMode=false
readMode=false
writeMode=false
appendMode=false

# Check passed parameters with regex
parameterCount=0
for parameter ; do 

	# Regex verboseMode (-v) - combinable with w, a and r 
	if [[ $parameter =~ ^-(r|w|a)?v(r|w|a)?$ ]] ; then	 
		verboseMode=true
	fi

	# Regex readMode (-r) - combinable with v
	if [[ $parameter =~ ^-v?rv?$ ]] ; then
		readMode=true

	
	# Regex writeMode (-w) - combinable with v
	elif [[ $parameter =~ ^-v?wv?$ ]] ; then
		writeMode=true

	# Regex appendMode (-a) - combinable with v
	elif [[ $parameter =~ ^-v?av?$ ]] ; then
		appendMode=true

	# Regex showHelp (-h) 
	elif [[ $parameter =~ ^-h$ ]] ; then
		showHelp
		exit	

	# all other parameters are in dependence of the mode data or files		
	else
	     userInput[parameterCount]=$parameter	
	     parameterCount=$parameterCount+1

	fi

done

# Call desired function
if  [ $readMode = true ] || [ $writeMode = true ] || [ $appendMode = true ] ; then 
	checkUserInputExists "${userInput[*]}"	
	files=""
	fileCount=0	
	if [ $readMode = true ] ; then				
		if [ $result = false ] ; then 
			readFileName 				
		fi 		 
		readFiles "${userInput[*]}"
	elif [ $writeMode = true ] ; then
		if [ $userInputExists = false ] ; then 
			readTextAndFileName
		fi 		 
		writeFile
	elif [ $appendMode = true ] ; then
		funkverlaengern
	fi
else
	showHelp
fi


