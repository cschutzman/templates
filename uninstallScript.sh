#!/usr/bin/env bash
#
### HEADER
# Distribution Title:
# Package Title:
# ScriptTitle: Preflight
## VERSION HISTORY
# VERSION 	CONTRIBUTOR					CHANGELOG
#	0.0		conor@mac.com				TEMPLATE CREATION
#
### DEFINITIONS
## VARIABLES
softwareTitle=
sectionTitle=
resourceLocation=$(/usr/bin/dirname "$0")
## ARRAYS
appFiles=(
	''
)
## IMPORT SHARED VALUES
if [[ -s "${resourceLocation}/sharedLib.sh" ]]; then
    source "${resourceLocation}/sharedLib.sh"
else
    /usr/bin/logger "Shared resources not available, quitting."
    echo "Shared resources not available, quitting."
    exit 1
fi
#
### BODY
## QUIT APP
if [[ $(/usr/bin/top -l 1 | /usr/bin/grep -c '') -gt 0 ]]; then
	displayNotification 'Quitting '
	/usr/bin/osascript -e 'tell application "" to quit'
fi
## REMOVE FILES
writeLog "Files removed:"
for eachFile in "${appFiles[@]}"; do
	[[ -e "$eachFile" ]] && rm -rfv "$eachFile" >> "$logFile"
	[[ -e "/Users/$consoleUser/$eachFile" ]] && rm -rfv "/Users/$consoleUser/$eachFile" >> "$logFile"
done
## REMOVE RECEIPTS
writeLog "Receipts removed:"
receiptList=$(/usr/sbin/pkgutil --packages | grep "")
for eachReceipt in "${receiptList[@]}"; do
	/usr/sbin/pkgutil --forget "$eachReceipt" >> "$logFile"
done
## FOO
echo foo
#
### FOOTER
exit 0
