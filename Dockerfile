FROM centos:latest 
MAINTAINER michaelsteven@hepfer.org

ENV LANG en_US.UTF-8 

RUN yum -y install java-1.8.0-openjdk-devel

WORKDIR /data
ENV JAVA_HOME /usr/bin/java


RUN rpm -Uvh https://yum.opennms.org/repofiles/opennms-repo-branches-foundation-2016-rhel7.noarch.rpm
RUN yum -y install jicmp
RUN yum -y install jicmp6
RUN yum -y install rrdtool
RUN yum -y install jrrd
RUN yum -y install jrrd2
RUN yum -y install opennms-core
RUN yum -y install opennms-webapp-jetty
RUN yum -y install opennms-plugin-protocol-xml
RUN yum -y install opennms-plugin-provisioning-snmp-asset
RUN yum -y install opennms-plugin-provisioning-snmp-hardware-inventory
RUN yum -y install iplike
RUN yum -y install net-snmp
RUN yum -y install net-snmp-utils
RUN yum -y install grafana
RUN yum -y install grafana-opennms-plugin
RUN yum -y install perl-XML-Twig
RUN yum -y install bind-utils

RUN yum -y install which
 
# Webapp 
EXPOSE 8980 

# JMX 
EXPOSE 18980 
 
# Karaf RMI 
EXPOSE 1099 
 
# Karaf SSH 
EXPOSE 8101  
 
# MQ 
EXPOSE 61616 

RUN _=$(date)

COPY opennms-datasources.xml /opt/opennms/etc/ 
COPY bootstrap.sh /opt/opennms/bin/
RUN chmod +x /opt/opennms/bin/bootstrap.sh
 
CMD ["/opt/opennms/bin/bootstrap.sh"] 

VOLUME  ["/etc/opennms", "/var/lib/opennms"]
