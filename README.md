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
cat localhost_access_log.2021-06-19.txt | grep 'GET \/search' | cut -d " " -f1 | wc -l

OR

cat localhost_access_log.2021-06-19.txt | awk '/GET \/search/ {print $1}' | wc -l

## Number of unique ips/hosts searching on opengrok
cat localhost_access_log.2021-06-19.txt | grep 'GET \/search' | cut -d " " -f1 | uniq | wc -l

OR

cat localhost_access_log.2021-06-19.txt | awk '/GET \/search/ {print $1}' | uniq | wc -l


## Git configuration

### Git repos from different accounts

Create a config file under /root/.ssh/ directory

The content of the config can look something like below

Host github.houston.softwaregrp.net
HostName github.houston.softwaregrp.net
User root
IdentityFile ~/.ssh/id_rsa

Host github.com
HostName github.com
User root
IdentityFile ~/.ssh/id_rsa_github_personal

Notice that the User is root here. 

RUN chmod 400 /root/.ssh/config

RUN chown root:root /root/.ssh/config