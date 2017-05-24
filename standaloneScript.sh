#!/usr/bin/env bash
#
### HEADER
# Product Title:
## VERSION HISTORY
# VERSION 	CONTRIBUTOR					CHANGELOG
#	0.0		conor@mac.com				Template Creation
#
### DEFINITIONS
## VARIABLES
logTitle=
productTitle=
logFolder="/Library/Logs/"
logFile="${logFolder}/${logTitle}.log"
consoleUser=$(/usr/bin/stat -f %Su '/dev/console')
## FUNCTIONS
writeLog(){ /usr/bin/logger -s -t "${consoleUser} ${productTitle}" -p "user.${1}" "$2" 2>> "$logFile"; }
exitError(){
    /usr/bin/osascript > /dev/null <<EOT
    tell application (path to frontmost application as text)
        display dialog "$1" buttons {"Quit"} default button 1 with title "Mac IT" with icon Stop
    end tell
EOT
exit 1
}
displayDialog(){
    /usr/bin/osascript > /dev/null <<EOT
    tell application (path to frontmost application as text)
        display dialog "$1" buttons {"OK"} default button 1 with title "Mac IT"
    end tell
EOT
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
#
### BODY
## FOO
echo foo
#
### FOOTER
exit 0
