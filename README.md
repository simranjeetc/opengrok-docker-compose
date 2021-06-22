## Enable tomcat valve logs

RUN sed -i 's#<Disabled className="org.apache.catalina.valves.AccessLogValve"#<Valve className="org.apache.catalina.valves.AccessLogValve"#' /usr/local/tomcat/conf/server.xml

RUN sed -i 's#connectionTimeout="20000"#connectionTimeout="20000" enableLookups="true"#' /usr/local/tomcat/conf/server.xml

RUN chmod -R 777 /usr/local/tomcat/logs


## Build image with opengrok's image
### Navigate to dockerfile directory and execute the below command

docker build -t opengrok-valve:1 .


## Execute docker-compose-1-7-11.yml

docker-compose -f docker-compose-1-7-11.yml up -d


## Capture search query count from access logs
awk '/GET \/search/ {print $1}' localhost_access_log.* | wc -l

OR 

cat localhost_access_log.2021-06-19.txt | grep 'GET \/search' | cut -d " " -f1 | wc -l

OR

cat localhost_access_log.2021-06-19.txt | awk '/GET \/search/ {print $1}' | wc -l

## Number of unique ips/hosts searching on opengrok
awk '/GET \/search/ {print $1}' localhost_access_log.* | sort | uniq | wc -l

OR

cat localhost_access_log.2021-06-19.txt | grep 'GET \/search' | cut -d " " -f1 | sort | uniq | wc -l

OR

cat localhost_access_log.2021-06-19.txt | awk '/GET \/search/ {print $1}' | sort | uniq | wc -l
