/****
finally, we reach to the step to startup  vitess, also, there are some traps in the process. 
if newbies or DBAs don't modify vitess MySQL template configuration file correctly, 
normally, we can see batch of error message and feel gulity for ourselves, what did we do ? who are we ? where are we ? 
 
in this period, we need to modify : 
/xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/default.cnf
/xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/master_mysql57.cnf
/xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/master_mysql56.cnf
/xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/replica.cnf

also, I think vitess should support MySQL 8.0 soon....
user: mysql 
****/

step 1.
/****
downloading package, and expanding it to the directory 
ex: I put it to /xxxx 
****/
cd /xxxx
wget https://github.com/planetscale/vitess-releases/releases/download/8cdd456/vitess-release-8cdd456.tar.gz
gzip -d vitess-release-8cdd456.tar.gz
tar -xvf  vitess-release-8cdd456.tar

step 2. 
/****
modifing all cnf files. there is the most important step of whole installation, if DBA misses this step, it is impoosbile to start up vitess. 
please comments the orginal parameters and add new parameters as following .
ex: if you find log-slave-updates  at cnf file , you need to :

#####log-slave-updates
log_slave_updates = ON

this is more friendly and more accurate. 

****/
vi /xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/default.cnf

binlog_format = ROW
basedir = /usr
lc_messages_dir=/usr/share/mysql
bind_address = 0.0.0.0

rpl_semi_sync_master_enabled = 1  
rpl_semi_sync_master_timeout = 1000   
rpl_semi_sync_slave_enabled = 1
 
step 3.
vi /xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/master_mysql57.cnf
 
gtid_mode = ON
enforce_gtid_consistency = ON
log_bin= mysql-bin
log_slave_updates = ON 
innodb_use_native_aio = 0

step 4. 
vi /xxxx/kubernetes/vitess-release-8cdd456/config/mycnf/master_mysql56.cnf

gtid_mode = ON
enforce_gtid_consistency = ON
log_bin= mysql-bin
log_slave_updates = ON 
innodb_use_native_aio = 0

vi /lb0500/kubernetes/vitess-release-8cdd456/config/mycnf/replica.cnf
#####log-slave-updates
log_slave_updates = ON

step 5.
vi /lb0500/kubernetes/vitess-release-8cdd456/config/mycnf/master_mysql80.cnf

gtid_mode = ON
enforce_gtid_consistency = ON
log_bin= mysql-bin
log_slave_updates = ON 

