#!/usr/bin/env bash

export JAVA_HOME=/jre
AGENT_DIR="${HOME}/agent"
TEAMCITY_SERVER="$(ip r | head -n 1 | awk '{print $3}'):8111"

cd && pwd

seconds=1
until $(curl -sO --fail $TEAMCITY_SERVER/update/buildAgent.zip 2>&1 >/dev/null); do
  echo "[$(date)] waiting for $TEAMCITY_SERVER to be available"
  sleep $((seconds++))
done

if [ ! -d "$AGENT_DIR" ]; then
    echo "Setting up TeamCity agent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR
    unzip -q -d $AGENT_DIR $HOME/buildAgent.zip && \
    rm $HOME/buildAgent.zip && \ 
    chmod +x $AGENT_DIR/bin/agent.sh && \
    if [ -d $AGENT_DIR/conf ]; then
      echo "serverUrl=${TEAMCITY_SERVER}" > $AGENT_DIR/conf/buildAgent.properties
      echo "name=${AGENT_INSTANCE_NAME}" >> $AGENT_DIR/conf/buildAgent.properties
      echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
      echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
      echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
    else
      echo "[$(date)] failed"
    fi
else
    echo "Using agent at ${AGENT_DIR}."
fi
exec $AGENT_DIR/bin/agent.sh "$@"
