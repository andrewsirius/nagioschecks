#!/bin/sh

# Arguments:
#  $1 = host_name (Short name of host 
#  $2 = state_string (A string representing the status of
#       the given service - "OK", "WARNING", "CRITICAL"
#       or "UNKNOWN")
#  $3 = plugin_output (A text string that should be used
#       as the plugin output for the host checks)
#
USER=""
PASSWORD=""
URL="http://????/cgi-bin/icinga/cmd.cgi"

# Convert the state string to the corresponding return code
return_code=-1

case "$2" in
    UP)
        return_code=0
        ;;
    DOWN)
        return_code=1
        ;;
    UNREACHABLE)
        return_code=2
        ;;
    UNKNOWN)
        return_code=-1
        ;;
esac


/usr/bin/wget -O - --user=$USER --password=$PASSWORD --no-check-cert $URL'?cmd_typ=87''&cmd_mod=2''&host='"$1"'&plugin_state='"$return_code"'&plugin_output='"$3"'&btnSubmit=Commit'

