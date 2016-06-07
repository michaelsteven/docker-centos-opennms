FROM centos:latest 
MAINTAINER michaelsteven@hepfer.org

ENV LANG en_US.UTF-8 

RUN yum -y install java-1.8.0-openjdk-devel

WORKDIR /data
ENV JAVA_HOME /usr/bin/java


RUN rpm -Uvh https://yum.opennms.org/repofiles/opennms-repo-branches-foundation-2016-rhel7.noarch.rpm
RUN yum -y install jicmp jicmp6 rrdtool jrrd jrrd2 opennms-core opennms-webapp-jetty opennms-plugin-protocol-xml opennms-plugin-provisioning-snmp-asset opennms-plugin-provisioning-snmp-hardware-inventory iplike net-snmp net-snmp-utils grafana grafana-opennms-plugin perl-XML-Twig bind-utils which
 
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
