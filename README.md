# docker-centos-opennms
Docker image of OpenNMS based on CentOS

First pull and run the postgres database docker image:

docker run --name opennms-database -e POSTGRES_PASSWORD=foo -d postgres

Then run this OpenNMS docker image:

docker run --privileged -p 0.0.0.0:8980:8980 --link=opennms-database:db -e DB_POSTGRES_PASSWORD=foo --name opennms-poc -it -d opennms:latest

The privileged command is present to work around an error that occured when an OpenNMS script is run to configure the database. (http://issues.opennms.org/browse/NMS-8200) 
