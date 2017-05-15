# More info: 
# https://help.ubuntu.com/lts/serverguide/index.html
# http://do.co/2bwsv2X (Digital Ocean: How To Install LAMP stack on Ubuntu 16.04)

# fetch lists of updates
sudo apt-get update

######################
# ESSENTIAL UTILITIES
######################
sudo apt-get install curl
sudo apt-get install wget

#######################
# APACHE INSTALLATION
#######################
sudo apt install apache2

# Apache2 is configured by placing directives in plain text configuration files. 
# These directives are separated between the following files and directories:
#  1. apache2.conf: the main Apache2 configuration file. Contains settings that are global to Apache2.

#  2. httpd.conf: historically the main Apache2 configuration file, named after the httpd daemon. 
#     Now the file does not exist. In older versions of Ubuntu the file might be present, but empty,
#     as all configuration options have been moved to the below referenced directories.

#  3. conf-available: this directory contains available configuration files. 
#     All files that were previously in /etc/apache2/conf.d should be moved to /etc/apache2/conf-available.

#  4. conf-enabled: holds symlinks to the files in /etc/apache2/conf-available. 
#     When a configuration file is symlinked, it will be enabled the next time apache2 is restarted.

#  5. envvars: file where Apache2 environment variables are set.

#  6. mods-available: this directory contains configuration files to both load modules and configure them. 
#     Not all modules will have specific configuration files, however.

#  7. mods-enabled: holds symlinks to the files in /etc/apache2/mods-available. 
#     When a module configuration file is symlinked it will be enabled the next time apache2 is restarted.

#  8. ports.conf: houses the directives that determine which TCP ports Apache2 is listening on.

#  9. sites-available: this directory has configuration files for Apache2 Virtual Hosts. 
#     Virtual Hosts allow Apache2 to be configured for multiple sites that have separate
#     configurations.

# 10. sites-enabled: like mods-enabled, sites-enabled contains symlinks to the 
#     /etc/apache2/sites-available directory. Similarly when a configuration file
#     in sites-available is symlinked, the site configured by it will be active once
#     Apache2 is restarted.

# 11. magic: instructions for determining MIME type based on the first few bytes of a file.

# In addition, other configuration files may be added using the Include directive, and
# wildcards can be used to include many configuration files. Any directive may be placed
# in any of these configuration files. Changes to the main configuration files are only
# recognised by Apache2 when it is started or restarted.

# The server also reads a file containing mime document types; the filename is set by the
# TypesConfig directive, typically via /etc/apache2/mods-available/mime.conf, which might
# also include additions and overrides, and is /etc/mime.types by default.

# MORE INFO FOR CONFIGURING APACHE CAN BE FOUND HERE:
# https://help.ubuntu.com/lts/serverguide/httpd.html

#####################
# MYSQL INSTALLATION
#####################

# Install mysql server on ubuntu 16.04 and Mint 18
sudo apt-get install mysql-server mysql-client

# You can edit the /etc/mysql/my.cnf file to configure the basic settings -- log file, port number, etc.

# Run mysql_secure_installation to secure your installation.
# Do this for all your production servers.
sudo mysql_secure_installation

# To test if mysql is running
sudo netstat -tap | grep mysql

# Should produce output like below:
# tcp        0      0 localhost:mysql         *:*                LISTEN      2556/mysqld

# OR
sudo systemctl status mysql.service
# OR
sudo systemctl status mysql

# If the server is not running correctly, you can type the following command to start it:
sudo systemctl restart mysql.service

# If you would like to change the MySQL root password, in a terminal enter:
sudo dpkg-reconfigure mysql-server-5.5
# OR
sudo dpkg-reconfigure mysql-server-5.6
# OR
sudo dpkg-reconfigure mysql-server-5.7

# Shut down MySQL:
sudo systemctl stop mysql.service
# OR
sudo systemctl stop mysql

# Start MySQL:
sudo systemctl start mysql.service
# OR
sudo systemctl start mysql

# Restart Mysql
sudo systemctl restart mysql.service
# OR
sudo systemctl restart mysql

# MySQL Tuner is a useful tool that will connect to a running MySQL instance
# and offer suggestions for how it can be best configured for your workload.
# The longer the server has been running for, the better the advice mysqltuner
# can provide. In a production environment, consider waiting for at least 24 hours
# before running the tool. You can get install mysqltuner from the Ubuntu repositories:
sudo apt install mysqltuner

# Then once its been installed, run it:
mysqltuner
# and wait for its final report.
# The top section provides general information about the database server,
# and the bottom section provides tuning suggestions to alter in your my.cnf.
# Most of these can be altered live on the server without restarting, look through
# the official MySQL documentation for the relevant variables to change in production. 

####################
# PHP INSTALLATION
####################
# Installing PHP 5.5, 5.6 or 7.X on Ubuntu 16.04 LTS or Mint 18

# First, Remove all the stock php packages by
# listing all installed php packages with dpkg -l | grep php| awk '{print $2}' |tr "\n" " " 
# and then remove unneeded packages with sudo aptitude purge.
# Command below will remove all the currently installed stock php packages:
sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`

# Add the ppa containing php5.5, 5.6 & 7.X packages.
# NOTE that ubuntu 16.04 and Mint 18 ship with only php 7.X 
sudo add-apt-repository ppa:ondrej/php

# update the repositories
sudo apt-get update

# Make sure you run your software update manager tool 
# if the php5.5 and 5.6 packages are not still available

##########################################################
# INSTALLING PHP AND LINKING IT TO THE APACHE WEBSERVER
##########################################################
# you can enter one of the following commands at a terminal prompt:
##########################################################################################
##########################################################################################
# The comand below installs the default PHP version for ubuntu 16.04 (Which is PHP 7)
# and links that version of PHP to the apache 2 webserver
# default php version for the ubuntu version; in this case PHP 7 for ubuntu 16.04
sudo apt install php libapache2-mod-php

# The command below installs PHP7.1 for ubuntu 16.04
# and links that version of PHP to the apache 2 webserver
# PHP 7.1 for ubuntu 16.04
sudo apt install php7.1 libapache2-mod-php7.1

# The comand below installs PHP7.0 for ubuntu 16.04
# and links that version of PHP to the apache 2 webserver
# PHP 7.0 for ubuntu 16.04
sudo apt install php7.0 libapache2-mod-php7.0

# The comand below installs PHP5.6 for ubuntu 16.04
# and links that version of PHP to the apache 2 webserver
# PHP 5.6 for ubuntu 16.04
sudo apt install php5.6 libapache2-mod-php5.6

# The comand below installs PHP5.5 for ubuntu 16.04
# and links that version of PHP to the apache 2 webserver
# PHP 5.5 for ubuntu 16.04
sudo apt install php5.5 libapache2-mod-php5.5

# You MUST run the following command at a terminal prompt to
# restart your web server to pickup the php changes:
sudo systemctl restart apache2.service 
# OR
sudo systemctl restart apache2

# NOTE: To switch between PHP versions for your apache webserver
#       remember to run the command below before running any of the 
#       above commands to install the desired version of PHP
sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
########################################################################################
########################################################################################

##########################################################
# INSTALLING PHP WITHOUT LINKING TO THE APACHE WEBSERVER
##########################################################

# First, Remove all the stock php packages by
# listing all installed php packages with dpkg -l | grep php| awk '{print $2}' |tr "\n" " " 
# and then remove unneeded packages with sudo aptitude purge.
# Command below will remove all the currently installed stock php packages:
sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`

# install php5.5
sudo apt-get install php5.5

# install php5.6
sudo apt-get install php5.6

# install php7.0
sudo apt-get install php7.0

# install php7.1
sudo apt-get install php7.1

################################################################
# AFTER INSTALLING PHP WITH/WITHOUT libapache2-mod-php or
# libapache2-mod-php#.#, YOU CAN INSTALL OTHER OPTIONAL
# PHP MODULES. JUST REMEMBER TO INSTALL THE PACKAGE FOR
# THE SPECIFIC VERSION OF PHP THAT YOU INSTALLED EARLIER.
# E.G. php5.6-mysql for PHP 5.6, php5.5-mysql for PHP 5.5, etc.
################################################################

# Some PHP modules like xdebug don't have a version specific package
# but rather their packages are named without a php version number
# (e.g. php-xdebug).
# Below are some popular php modules that wil most likely be useful for most scenarios
sudo apt-get install php5.6-intl php5.6-mysql php5.6-sqlite3 php5.6-xsl php5.6-bcmath \
php5.6-curl php5.6-gd php5.6-json php5.6-readline php5.6-zip \
php5.6-bz2 php5.6-gmp php5.6-ldap php5.6-opcache php5.6-mbstring \
php5.6-pgsql php5.6-xml php5.6-cli php5.6-mcrypt php5.6-soap php5.6-xmlrpc php-xdebug

# Configure PHP to Use Xdebug
# add the following line to php.ini excluding the first # character: 
#zend_extension="/wherever/you/put/it/xdebug.so"
# For example: /usr/lib/php/20151012/xdebug.so
#
# Note that php.ini is usually located in 
#   /etc/php/[5.5|5.6|7.0|7.1]/cli/php.ini for the cli version of php
#   /etc/php/[5.5|5.6|7.0|7.1]/apache2/php.ini for the libapache2-mod-php version of php
#
# Be sure to only add the entry to ONLY ONE of the php.ini files; either the one for the
# cli version of php or the one for the libapache2-mod-php version of php.
#
# Finally Restart your webserver.

# Write a PHP page that calls 'phpinfo()' Load it in a browser and look for the info
# on the Xdebug module. If you see it next to the Zend logo, you have been successful!
# You can also use 'php -m' if you have a command line version of PHP, it lists all
# loaded modules. Xdebug should appear twice there (once under 'PHP Modules' and
# once under 'Zend Modules').

# You can run the following command at a terminal prompt
# to restart your web server to pickup the php changes:
sudo systemctl restart apache2.service 
# OR
sudo systemctl restart apache2

# to get a list of all installable php packages run the command below:
apt-cache search ^php- | cat

# To find out what a php module does,
# you can run the command below with the desired php module's name
# For example, to find out what the php-cli module does, we could type this:
apt-cache show php-cli


# Make sure you have already installed apache and mysql;
# see https://gist.github.com/rotexdegba/d0cab757b5194a58c93db5ab6df7dc67
# for instructions.

# install rails
# https://help.ubuntu.com/lts/serverguide/ruby-on-rails.html
sudo apt install rails

# install comman dependencies
sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev make libmysqlclient-dev imagemagick libmagickcore-dev libmagickwand-dev

#install passenger mod for apache to run rails
sudo apt-get install libapache2-mod-passenger

sudo mkdir -p /opt/redmine

# download redmine and move it (e.g `sudo mv /download/path/redmine-3.3.1 /opt/redmine/`) to 
# /opt/redmine so we get some thing like /opt/redmine/redmine-3.3.1
# then cd /opt/redmine/redmine-3.3.1

# Run the SQL statement below; Don't forget to replace your_password_here with the password that you specified in the
# config/database.yml file while you were configuring the database for Redmine.

CREATE DATABASE redmine CHARACTER SET UTF8;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'your_password_here';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';

sudo mv ./config/database.yml.example ./config/database.yml

# edit  ./config/database.yml with the correct db credential values

sudo gem install bundler

bundle install --without development test

# create a secret token for the Redmine session
bundle exec rake generate_secret_token

# Next, we need to create the structure (tables, indexes, and so on) of the Redmine database:
RAILS_ENV=production bundle exec rake db:migrate

# Finally, we need to insert initial data (such as trackers, the administrator account, and so on) into the database:
RAILS_ENV=production bundle exec rake redmine:load_default_data

# Now Configure Apache
cd /etc/apache2

# Now, create the redmine.conf file in the sites-available subdirectory with the following content (do this under root):
<VirtualHost *:3000>
        RailsEnv production
        DocumentRoot /opt/redmine/redmine-3.2.0/public
        <Directory "/opt/redmine/redmine-3.2.0/public">
                Allow from all
                Require all granted
        </Directory>
</VirtualHost>

# This is the configuration of the virtual host that will run Redmine. However, this is not the only virtual host that we currently have.
# Please note that Redmine, which is installed and configured this way, is going to run from your user account. 
# If you prefer to use another user, www-data, for example,  you need to add PassengerDefaultUser www-data
# to your virtual host configuration, and change the owner of the redmine-3.2.0 directory by executing
# chown www-data:www-data /opt/redmine/redmine-3.2.0 -R.

# enable the redmine.conf 
sudo a2ensite redmine

# add port 3000 to the /etc/apache2/ports.conf file like so:
Listen 3000

# restart apache
sudo service apache2 reload


# Good books for redmine:
# https://www.packtpub.com/networking-and-servers/mastering-redmine-second-edition
# https://www.packtpub.com/big-data-and-business-intelligence/redmine-cookbook

# Follow instructions here http://www.redmine.org/projects/redmine/wiki/RedmineInstall
