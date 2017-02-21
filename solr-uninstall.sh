sudo find / -iname "solr"
   sudo service solr stop
   sudo rm -r /var/solr
   sudo rm -r /opt/solr-6.3.0
   sudo rm -r /opt/solr
   sudo rm /etc/init.d/solr
   sudo userdel --remove  solr
   sudo groupdel solr
   sudo rm -f -r /var/db/sudo/solr
   sudo find / -iname "solr"
