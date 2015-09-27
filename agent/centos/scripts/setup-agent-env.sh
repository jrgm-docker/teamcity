#!/usr/bin/env bash

set -e

if [ -z "$SERVER_PORT_8111_TCP_ADDR" ]; then
    echo "Fatal error: SERVER_PORT_8111_TCP_ADDR is not set."
    echo "Check the link commands for this container."
    echo
    exit
fi

if [ -z "$TEAMCITY_AGENT_OWNPORT" ]; then
    echo "Fatal error: TEAMCITY_AGENT_OWNPORT is not set."
    echo "Launch this container with -e TEAMCITY_AGENT_OWNPORT=91nn."
    echo
    exit
fi

# `fig` will configure /etc/hosts so that `server` points to $SERVER_PORT_8111_TCP_ADDR
export TEAMCITY_SERVER=http://server:8111
echo TEAMCITY_SERVER $TEAMCITY_SERVER
echo TEAMCITY_AGENT_OWNPORT $TEAMCITY_AGENT_OWNPORT

TEAMCITY_SERVER=$TEAMCITY_SERVER TEAMCITY_AGENT_OWNPORT=$TEAMCITY_AGENT_OWNPORT /scripts/setup-agent.sh
