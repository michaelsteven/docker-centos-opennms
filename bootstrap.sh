#!/bin/bash

declare OPENNMS_HOME=/opt/opennms

if [ ! -d ${OPENNMS_HOME} ]; then
  echo "OpenNMS home directory doesn't exist in ${OPENNMS_HOME}"
  exit
fi

cd ${OPENNMS_HOME}/etc
sed -i s/PG_HOST/$(echo $DB_PORT_5432_TCP_ADDR)/g opennms-datasources.xml
sed -i s/PG_PORT/$(echo $DB_PORT_5432_TCP_PORT)/g opennms-datasources.xml
sed -i s/PG_PASSWORD/$(echo $DB_POSTGRES_PASSWORD)/g opennms-datasources.xml

# Expose the Karaf shell 
sed -i s/sshHost.*/sshHost=0.0.0.0/g "${OPENNMS_HOME}/etc/org.apache.karaf.shell.cfg"
 
cd ${OPENNMS_HOME}/bin
./runjava -s
./install -dis
./opennms -f start
