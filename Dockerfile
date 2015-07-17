FROM	ubuntu:14.04
MAINTAINER	kload "kload@kload.fr"

RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive \
	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d && \
	chmod +x /usr/sbin/policy-rc.d && \
  apt-get update && \
  apt-get install -y wget && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > \
  /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add - && \
	apt-get update && \
	apt-get install -y -q postgresql-9.4 postgresql-contrib-9.4 && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get clean && \
	rm /usr/sbin/policy-rc.d && \
	echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.4/main/pg_hba.conf && \
	sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.4/main/postgresql.conf

ADD	. /usr/bin
RUN	chmod +x /usr/bin/start_pgsql.sh

EXPOSE 5432
