#!/usr/bin/env bash
#
### HEADER
# Distribution Title:
# Package Title:
# ScriptTitle: Preflight
## VERSION HISTORY
# VERSION 	CONTRIBUTOR					CHANGELOG
#	1.0		conor.schutzman@te.com		Initial Development
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
## QUIT APP
if [[ $(/usr/bin/top -l 1 | /usr/bin/grep -c '') -gt 0 ]]; then
	displayNotification 'Quitting '
	/usr/bin/osascript -e 'tell application "" to quit'
fi
## FOO
echo foo
#
### FOOTER
exit 0
