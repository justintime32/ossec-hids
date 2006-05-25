#!/bin/sh
# Shell script update functions for the OSSEC HIDS
# Author: Daniel B. Cid <daniel.cid@gmail.com>
# Last modification: May 24, 2006


FALSE="false"
TRUE="true"

##########
# doUpdatecleanup 
##########
doUpdatecleanup()
{
    . ${OSSEC_INIT}

    if [ "X$DIRECTORY" = "X" ]; then
        # Invalid ossec init file. Unable to update
        echo "${FALSE}"
        return 1;
    fi
    
    # Checking if the directory is valid.
    echo $DIRECTORY | grep -E "^/[a-zA-Z0-9/-]{3,128}$" > /dev/null 2>&1
    if [ ! $? = 0 ]; then
        echo "${FALSE}"
        return 1;
    fi
}


##########
# getPreinstalled 
##########
getPreinstalled()
{
    . ${OSSEC_INIT}

    # agent
    cat $DIRECTORY/etc/ossec.conf | grep "<client>" > /dev/null 2>&1
    if [ $? = 0 ]; then
        echo "agent"
        return 0;
    fi
    
    cat $DIRECTORY/etc/ossec.conf | grep "<remote>" > /dev/null 2>&1
    if [ $? = 0 ]; then
        echo "server"
        return 0;
    fi
    
    echo "local"
    return 0;   
}


##########
# getPreinstalledDir
##########
getPreinstalledDir()
{
    . ${OSSEC_INIT}
    echo "$DIRECTORY"
    return 0;
}


##########
# UpdateStartOSSEC
##########
UpdateStartOSSEC()
{
   . ${OSSEC_INIT}
   
   $DIRECTORY/bin/ossec-control start 
}


##########
# UpdateStopOSSEC
##########
UpdateStopOSSEC()
{
   . ${OSSEC_INIT}
   
   $DIRECTORY/bin/ossec-control stop 
}
