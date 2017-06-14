FROM ubuntu:14.04
RUN apt-get update && apt-get install -y apache2

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN apt-get install -y subversion 
RUN apt-get install -y subversion-tools 
RUN apt-get install -y libapache2-svn

EXPOSE 80 

COPY resources/dav_svn.conf /etc/apache2/mods-available/dav_svn.conf
COPY resources/svn_repo.sh /var/svn_repo.sh
RUN chmod 775 /var/svn_repo.sh
RUN /var/svn_repo.sh

CMD apache2 -DFOREGROUND
