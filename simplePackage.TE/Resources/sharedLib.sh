#!/usr/bin/env bash
#
### HEADER
# Distribution Title:
# Script Title: Shared Libraries
## VERSION HISTORY
# Version   Contributor                 Changelog
#   1.0     conor.schutzman@te.com      Initial development
#
### DEFINITIONS
## VARIABLES
logFolder="/Library/Logs/TEIS"
logFile="${logFolder}/${softwareTitle}.log"
consoleUser=$(/usr/bin/stat -f %Su '/dev/console')
libraryLocation='/Library/TEIS'
## FUNCTIONS
writeLog(){ /usr/bin/logger -s -t "${consoleUser} ${softwareTitle} ${sectionTitle}" -p "user.${1}" "$2" 2>> "$logFile"; }
## SUB ROUTINES
displayNotification(){
	writeLog notice "$1"
	/usr/bin/osascript <<EOT
    tell application (path to frontmost application as text)
        display notification "$1" with title "TEIS Mac"
    end tell
EOT
}
displayDialog(){
    writeLog notice "$1"
    /usr/bin/osascript <<EOT
    tell application (path to frontmost application as text)
        display dialog "$1" buttons {"Quit","OK"} default button 2 cancel button 1 with title "TEIS Mac" with icon path to resource "TE Logo.png" in bundle "$resourceLocation"
    end tell
EOT
    if [[ "$?" = "1" ]]; then
        writeLog err "User opted to exit."
        exit 1
    fi
}
exitError(){
    writeLog err "$1"
    /usr/bin/osascript <<EOT
    tell application (path to frontmost application as text)
        display dialog "$1" buttons {"Quit"} default button 1 cancel button 1 with title "TEIS Mac" with icon path to resource "TE Logo.png" in bundle "$resourceLocation"
    end tell
EOT
exit 1
}
promptInput(){
	writeLog notice "$1"
    /usr/bin/osascript <<EOT
    tell application (path to frontmost application as text)
        text returned of (display dialog "$1" default answer "$2" buttons {"Quit","OK"} default button 2 cancel button 1 with title "TEIS Mac" with icon path to resource "TE Logo.png" in bundle "$resourceLocation")
    end tell
EOT
    if [[ "$?" = "1" ]]; then
        writeLog err "User opted to exit."
        exit 1
    fi
}
## LOGGING
[[ -d "$logFolder" ]] || mkdir -p -m 775 "$logFolder"
[[ $(/usr/bin/stat -f %u "$logFolder") -ne 0 ]] && /usr/sbin/chown -R root "$logFolder"
[[ $(/usr/bin/stat -f %g "$logFolder") -ne 0 ]] && /usr/bin/chgrp -R wheel "$logFolder"
[[ $(/usr/bin/stat -f %p "$logFolder") -ne 40755 ]] && /usr/sbin/chown -R 755 "$logFolder"
if [[ -e "$logFile" ]]; then
  [[ $(/usr/bin/stat -f %z "$logFile") -ge 1000000 ]] && mv "$logFile" "${logFile}.old"
fi
/usr/bin/touch "$logFile"
[[ $(/usr/bin/stat -f %u "$logFile") -ne 0 ]] && /usr/sbin/chown -R root "$logFile"
[[ $(/usr/bin/stat -f %g "$logFile") -ne 0 ]] && /usr/bin/chgrp -R wheel "$logFile"
[[ $(/usr/bin/stat -f %p "$logFile") -ne 100644 ]] && /usr/sbin/chown -R 644 "$logFile"