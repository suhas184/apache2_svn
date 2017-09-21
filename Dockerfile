FROM ubuntu:14.04
RUN apt-get -y update && apt-get install -y apache2

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR /var/svn

RUN apt-get install -y subversion subversion-tools libapache2-svn

EXPOSE 6000 80

RUN mkdir -p /var/svn && \
    cd /var/svn

COPY resources/dav_svn.conf /etc/apache2/mods-available/dav_svn.conf
COPY resources/start_apache2_svn.sh /var/start_apache2_svn.sh
RUN chmod +x /var/start_apache2_svn.sh

VOLUME ["/etc/apache2/"]

ENTRYPOINT ["/var/start_apache2_svn.sh"]
