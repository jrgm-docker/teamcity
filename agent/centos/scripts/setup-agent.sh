#!/usr/bin/env bash

set -e

export JAVA_HOME=/usr/java/default
AGENT_DIR="${HOME}/agent"

if [ -d "$AGENT_DIR" ]; then
    echo "Using the existing agent installation at ${AGENT_DIR}."
else
    mkdir -p $AGENT_DIR
    cd ${HOME}
    echo "Setting up TeamCity agent for the first time from ${TEAMCITY_SERVER}..."
    echo "Agent will be installed into ${AGENT_DIR}."

    set +e
    SLEEP=20
    while true; do 
	echo Waiting for the Teamcity server to provide buildAgent.zip
	sleep $SLEEP
	if wget --no-verbose $TEAMCITY_SERVER/update/buildAgent.zip; then
	    break
	fi
    done
    set -e

    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh

    echo "serverUrl=${TEAMCITY_SERVER}"       > $AGENT_DIR/conf/buildAgent.properties
    echo "ownPort=${TEAMCITY_AGENT_OWNPORT}" >> $AGENT_DIR/conf/buildAgent.properties
    echo "name="                             >> $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work"                   >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp"                   >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system"               >> $AGENT_DIR/conf/buildAgent.properties
fi

$AGENT_DIR/bin/agent.sh run
