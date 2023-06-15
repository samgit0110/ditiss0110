#/!usr/bin/bash

#install dependencies

apt-get install  -y make wget unzip autoconf libgd-dev php apache2-utils apache2 gcc  libc6 python python3 tree


# get source code 
read -p 'enter the link ' link

wget $link

#xtracting source code 

tar zxf nagios-4.4.5.tar.gz


# changing directory 

cd nagios-4.4.5



# configuring nagios with apache2

sh configure --with-httpd-config=/etc/apache2/sites-enabled/

# making 

make all



#group add useradd 

make install-groups-users

passwd nagios 

 # adding apache user to nagios group
usermod -a -G nagios www-data

# compiling code 

make all

make install

#daemonising nagios

make install-daemoninit

# activate command mode
make install-commandmode

# to  get  configuration file
make install-config

make install-webconf

# activate modes

a2enmod rewrite

a2enmod cgi
# creating passwd for nagiosadmin
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# verifying
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

# restart both apache2 and nagios
systemctl restart apache2
systemctl start nagios  



#plugings 

# instaling dependencies 
sudo apt-get install -y  build-essential automake autotools-dev bc dc gawk gettext libmcrypt-dev libnet-snmp-perl libssl-dev snmp
# installing  source code of plugings
wget http://192.168.1.251/sw/sec_tools/nagios/nagios-plugins-release-2.2.1.tar.gz

#extracting tar file

tar zxf nagios-plugins-release-2.2.1.tar.gz
#changing directory
cd nagios-plugins-release-2.2.1
# executing script to get configuration file
sudo tools/setup
# executing configure script
sudo ./configure
#Compiling code
sudo make
sudo make install
# restarting both apache2 and nagios
sudo systemctl restart apache2
sudo systemctl restart nagios

 

