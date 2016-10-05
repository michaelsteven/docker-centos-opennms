# docker-centos-opennms
Docker image of OpenNMS based on CentOS

First pull and run the postgres database docker image:

docker run --name opennms-database -e POSTGRES_PASSWORD=foo -d postgres:9.4

Then run this OpenNMS docker image:

docker run -p 0.0.0.0:8980:8980 --link=opennms-database:db -e DB_POSTGRES_PASSWORD=foo --name opennms-poc -it -d opennms:latest
