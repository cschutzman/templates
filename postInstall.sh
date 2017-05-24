#!/usr/bin/env bash
#
### HEADER
# Distribution Title:
# Package Title:
# ScriptTitle: Postflight
## VERSION HISTORY
# VERSION 	CONTRIBUTOR					CHANGELOG
#	0.0		conor@mac.com               Template Creation
#
### DEFINITIONS
## VARIABLES
softwareTitle=
sectionTitle=
resourceLocation=$(/usr/bin/dirname "$0")
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
## INSTALLATION
SectionTitle=Extraction
if [[ -e "$resourceLocation/$packageName" ]]; then
	writeLog "Executing $packageName"
	/usr/sbin/installer -pkg "$resourceLocation/$packageName" -target "/" -allowUntrusted >> "$logFile"
	if [[ "$?" -ne 0 ]]; then
    	writeLog err "An error occured when running ${packageName}."
    	exit 1
    fi
else
	writeLog "File Not Found: $packageName"
	ls -la "$resourceLocation" >> "$logFile"
fi
## FOO
echo foo
#
### FOOTER
exit 0
