#!/bin/bash
set -e

mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc $TEAMCITY_DATA_PATH/config
if [ ! -f "$TEAMCITY_DATA_PATH/lib/jdbc/postgresql-9.4-1209.jar" ];
then
    echo "Downloading postgress JDBC driver..."
    cd $TEAMCITY_DATA_PATH/lib/jdbc
    curl -sLO https://jdbc.postgresql.org/download/postgresql-9.4.1209.jar
fi

echo "Starting teamcity..."
exec /opt/TeamCity/bin/teamcity-server.sh run
