#!/bin/sh

# Arguments:
#  $1 = host_name (Short name of host that the service is
#       associated with)
#  $2 = svc_description (Description of the service)
#  $3 = state_string (A string representing the status of
#       the given service - "OK", "WARNING", "CRITICAL"
#       or "UNKNOWN")
#  $4 = plugin_output (A text string that should be used
#       as the plugin output for the service checks)
#
USER=""
PASSWORD=""
URL="http://????/cgi-bin/icinga/cmd.cgi"

# Convert the state string to the corresponding return code
return_code=-1

case "$3" in
    OK)
        return_code=0
        ;;
    WARNING)
        return_code=1
        ;;
    CRITICAL)
        return_code=2
        ;;
    UNKNOWN)
        return_code=-1
        ;;
esac



/usr/bin/wget -O - --user=$USER --password=$PASSWORD --no-check-cert $URL'?cmd_typ=30''&cmd_mod=2''&host='"$1"'&service='"$2"'&plugin_state='"$return_code"'&plugin_output='"$4"'&btnSubmit=Commit'

