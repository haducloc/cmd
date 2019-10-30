--- NGINX

/etc/nginx/conf.d/myvocab.conf

server {
        listen 80;
        listen [::]:80;

        server_name _;

        location / {
             proxy_pass http://localhost:8080/;
             proxy_set_header Host $host;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header X-Forwarded-Port $server_port;
        }
}

--- Download Derby

sudo wget http://apache.osuosl.org//db/derby/db-derby-10.14.2.0/db-derby-10.14.2.0-bin.tar.gz
sudo tar -xzvf db-derby-10.14.2.0-bin.tar.gz
sudo ln -s db-derby-10.14.2.0-bin derby

--- Download Java
sudo apt install openjdk-8-jdk

sudo adduser --no-create-home --disabled-password --disabled-login derby
sudo chown -R derby:derby derby*

chmod 755 /etc/init.d/derby
chmod 500 payara.jar


sudo nano /etc/systemd/system/myvocab.service
sudo systemctl daemon-reload

sudo rm -rf /var/log/journal/*

sudo rm /opt/apps/myvocab/logs/*
sudo rm myvocab.war

sudo cp myvocab.war /opt/apps/myvocab/
sudo chown -R myvocab:myvocab /opt/apps/myvocab/myvocab.war

sudo service derby stop
sudo service myvocab stop

sudo service derby start
sudo service myvocab start

journalctl -u derby
journalctl -u myvocab

$ export DERBY_HOME=/opt/derby
$ export DERBY_OPTS=-Dderby.system.home=/opt/derby-data

DERBY_HOME="/opt/derby"
DERBY_OPTS="-Dderby.system.home=/opt/derby-data"

java -jar /opt/derby/lib/derbyrun.jar ij

connect 'jdbc:derby://localhost:1527/MyVocab;create=true;user=app;password=x';
connect 'jdbc:derby://localhost:1527/MyVocab;user=app;password=x';

connect 'jdbc:derby://localhost:1527/MyVocab';

call SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.connection.requireAuthentication','true');
call SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.authentication.provider','BUILTIN');
call SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.user.app', 'x');
call SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.database.fullAccessusers', 'app');