FROM openjdk:8u171-jdk-slim

MAINTAINER Stackstate "http://www/stackstate.com"

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
	zip unzip ldap-utils procps curl && \
	mkdir -p /opt && \
		cd /opt && \
		curl -sO https://www.apache.org/dist/directory/apacheds/dist/2.0.0-M23/apacheds-2.0.0-M23.zip && \
		unzip apacheds-2.0.0-M23.zip && \
		rm apacheds-2.0.0-M23.zip

WORKDIR /opt/apacheds-2.0.0-M23

COPY config/config.ldif /opt/apacheds-2.0.0-M23/instances/default/conf/
COPY config/data.ldif /tmp/

RUN chmod ugo+x bin/apacheds.sh

RUN bin/apacheds.sh start && sleep 10 && ldapmodify -h 127.0.0.1 -p 10389 -x -a -v < /tmp/data.ldif && \
	bin/apacheds.sh stop && sleep 10 && \
	rm /tmp/data.ldif
	
EXPOSE 10389

CMD ["bin/apacheds.sh", "default", "run"]