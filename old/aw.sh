#!/bin/bash

funkverbose()
{
	if [ $verbose == 1 ] ; then
		echo -e "$1"
	fi

}

funklesen()
{
	
	funkverbose "Überprüfung ob die Datei/n vorhanden ist/sind \"${daten[*]}\"."
	for ((zaehler=0 ; zaehler<${#daten[*]} ; zaehler++)) ; do
		while [ ! -f ${daten[zaehler]} ] ; do 
			
			echo "Die Datei \"${daten[zaehler]}\" exsistiert nicht, geben Sie bitte einen gültigen Namen ein." 
			read daten[zaehler]
			
		done

	done
		
	funkverbose "Lesen der Datei/n \"${daten[*]}\"."

	for ((zaehler=0 ; zaehler<${#daten[*]} ; zaehler++)) ; do
		echo -e "---------------------------------------"
		echo -e "Datei: ${daten[zaehler]}"
		funkverbose "Länge: $(stat -c %s ${daten[zaehler]})"
		echo -e "Inhalt:\n"
		cat ${daten[zaehler]}
	done 
}

funkschreiben()
{
	dateiname=""
	
	funkverbose "Letzter Parameter wird für den Dateinamen verwendet:\"${daten[${#daten[*]}-1]}\"." 

	dateiname=${daten[${#daten[*]}-1]}
	unset daten[${#daten[*]}-1]
	funkverbose "überprüfung ob die Datei bereits vorhanden ist.."

	if [ -f $dateiname ] ; then 
	
		echo "Es exsistiert bereits eine Datei mit diesem Namen, soll diese überschrieben werden oder sollen die Daten angefügt werden?"
		read -p "Überschreiben (w) ; Anfügen (a) ; Alle anderen Tasten beenden das Skript >" eingabe

		if [ $eingabe == "a" ] ; then
			
			funkverbose "Text wird an die Datei angehängt"
			funkverbose "Länge vor dem Vorgang: $(stat -c %s $dateiname)"
			echo ${daten[*]} >> $dateiname
			funkverbose "Länge nach dem Vorgang: $(stat -c %s $dateiname)"
		elif [ $eingabe == "w" ] ; then
			
			funkverbose "Datei wird überschrieben und der Text hineingeschrieben"
				
			touch $dateiname
			
			echo ${daten[*]} > $dateiname
			funkverbose "Länge nach dem Vorgang: $(stat -c %s $dateiname)"
		else 
			echo "Skript wird beendet"
			exit

		fi
	else
		
		funkverbose "Datei wird erstellt und der Text hineingeschrieben"
		
			
		echo ${daten[*]} > $dateiname
		funkverbose "Länge nach dem Vorgang: $(stat -c %s $dateiname)"
	fi

}

funkverlaengern()
{

	dateiname=""
	
	funkverbose "Letzter Parameter wird für den Dateinamen verwendet:\"${daten[${#daten[*]}-1]}\"." 

	dateiname=${daten[${#daten[*]}-1]}
	unset daten[${#daten[*]}-1]
	funkverbose "überprüfung ob die Datei bereits vorhanden ist.."

	if [ -f $dateiname ] ; then 
	
		funkverbose "Text wird an die Datei angehängt"
	
		funkverbose "Länge vor dem Vorgang: $(stat -c %s $dateiname)"
		echo ${daten[*]} >> $dateiname
		
		funkverbose "Länge nach dem Vorgang: $(stat -c %s $dateiname)"
	else 	
		echo "Es exsistiert keine Datei mit diesem Namen, soll die Datei neuerstellt werden?"
		read -p "Erstellen (w) ; Alle anderen Tasten beenden das Skript >" eingabe

		if [ $eingabe == "w" ] ; then
			funkverbose "Datei wird erstellt und der Text hineingeschrieben"		
			echo ${daten[*]} > $dateiname
			funkverbose "Länge nach dem Vorgang: $(stat -c %s $dateiname)"
		else 
			echo "Skript wird beendet"
			exit	

		fi
		
	fi

}

hilfe()
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

funkdatenvorhanden()
{

funkverbose "Überprüfung ob Daten eingeben wurden"	
if [ "${daten[*]}" == "" ] ; then
	if   [ $lesen  == 1 ] ; then
		funkverbose "Dateiname wird eingelesen"

		while [ "${daten[*]}" == "" ] ; do
			read -p "Sie haben nur den Parameter zur Auswahl der Funktion eingeben. Geben Sie Bitte den Dateinamen ein! >" daten[0] 	
		done
	else 
		funkverbose "Inhalt und Dateiname werden eingelesen"
		while [ "${daten[1]}" == "" ] ; do
			echo -e  "Es fehlen Parameter. Ein Dateiname ist zwingend erforderlich, der Text ist optional".
			read -p "Geben Sie Ihren Text ein. (optional)  >" daten[0] 	
		
  			read -p "Geben Sie nun bitte den Dateinamen ein! >" daten[1] 	

		done
 	fi
 fi
}


zeichenkette="$*"
laenge=${#zeichenkette}
verbose=0
lesen=0
schreiben=0
verlaengern=0
zaehler=0
##Parameter Überprüfung

for parameter ; do 

	if [[ $parameter =~ ^-(r|w|a)?v(r|w|a)?$ ]] ; then
	 
		verbose=1
	
	fi
	
	if [[ $parameter =~ ^-v?rv?$ ]] ; then

		lesen=1
	
	elif [[ $parameter =~ ^-v?wv?$ ]] ; then

		schreiben=1
	
	elif [[ $parameter =~ ^-v?av?$ ]] ; then

		verlaengern=1
	
	elif [[ $parameter =~ ^-v$ ]] ; then

		verbose=1
	elif [[ $parameter =~ ^-h$ ]] ; then

		hilfe
		exit	
	
	else
	     daten[zaehler]=$parameter	
	     zaehler=$zaehler+1
	fi

done

if  (( $lesen+$schreiben+$verlaengern == 1 )) ; then 
	funkdatenvorhanden

	if [ $lesen == 1 ] ; then
		funklesen 
	elif [ $schreiben == 1 ] ; then
		funkschreiben
	elif [ $verlaengern == 1 ] ; then
		funkverlaengern
	fi
else
	hilfe
fi


