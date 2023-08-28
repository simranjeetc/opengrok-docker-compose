FROM opengrok/docker:1.7.11

RUN apt-get update && apt-get install -y vim && apt-get install -y cron && apt-get install -y rsyslog

RUN sed -i 's@#cron.*@cron.*                          /var/log/cron.log@' /etc/rsyslog.conf

COPY config/apt.conf /etc/apt/apt.conf

COPY config/proxy.conf /etc/apt/apt.conf.d/proxy.conf

RUN sed -i 's#<Disabled className="org.apache.catalina.valves.AccessLogValve"#<Valve className="org.apache.catalina.valves.AccessLogValve"#' /usr/local/tomcat/conf/server.xml

RUN sed -i 's#connectionTimeout="20000"#connectionTimeout="20000" enableLookups="true"#' /usr/local/tomcat/conf/server.xml

RUN chmod -R 777 /usr/local/tomcat/logs

COPY scripts/checkSync.sh /scripts/checkSync.sh

RUN chmod +x /scripts/checkSync.sh

RUN (crontab -l 2>/dev/null; echo "*/60 * * * * /scripts/checkSync.sh > /usr/local/tomcat/logs/cron-backup.log 2>&1") | crontab -

RUN rm -rf /root/.ssh

RUN mkdir /root/.ssh/

RUN mkdir /root/.ssh/config

RUN chmod 400 /root/.ssh/config

RUN chown root:root /root/.ssh/config

CMD service cron start && service rsyslog start && /scripts/start.py && /bin/bash
#CMD chmod 400 /root/.ssh/config && chown root:root /root/.ssh/config && service cron start && service rsyslog start && /scripts/start.py && /bin/bash
