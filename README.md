## Enable tomcat valve logs

RUN sed -i 's#<Disabled className="org.apache.catalina.valves.AccessLogValve"#<Valve className="org.apache.catalina.valves.AccessLogValve"#' /usr/local/tomcat/conf/server.xml

RUN sed -i 's#connectionTimeout="20000"#connectionTimeout="20000" enableLookups="true"#' /usr/local/tomcat/conf/server.xml

RUN chmod -R 777 /usr/local/tomcat/logs


## Build image with opengrok's image
### Navigate to dockerfile directory and execute the below command

docker build -t opengrok-valve:1 .


## Execute docker-compose-1-7-11.yml

docker-compose -f docker-compose-1-7-11.yml up -d
