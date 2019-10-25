/****
Vitess support MySQl 5.6, 5.7 and 8.0 I guess; however, I suggest to use MySQL 5.7 to work with Vitess because MySQL 5.7 is easier to use(I will explain it later). 
after I go through whole installation process, I find there are a lot of detail info hidden. 
we need to install MySQL 5.7 rpms and setup with semi-sync replication parameters to confirm there is no error when Vitess startup multi MySQl 5.7 databases
https://vitess.io/docs/get-started/local/
****/

step 1. 
/****
downloading MySQL 5.7 commnuity version rpms from mysql.com, ex: mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar 
comparing MySQL 5.6 ,  5.7 only uses /etc/my.cnf if you install rpm packages. so it is more convienient than MySQL 5.6 . 
user: root 
****/

tar -xvf mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar 
rpm -ivh mysql-community-client-5.7.28-1.el7.x86_64.rpm mysql-community-common-5.7.28-1.el7.x86_64.rpm mysql-community-devel-5.7.28-1.el7.x86_64.rpm mysql-community-libs-5.7.28-1.el7.x86_64.rpm mysql-community-server-5.7.28-1.el7.x86_64.rpm

step 2.
/****
modifing /etc/my.cnf, Vitess uses MySQL semi-sync replication to build replication 
user: root 
****/

#### for base dir and data dir 
basedir = /usr
datadir = /var/lib/mysql
port = 3306
server_id = 1
socket = /var/lib/mysql/mysql.sock
#### listener at IPV4 
bind_address=0.0.0.0

#### for semi-sync replication 
#### need to enalbe gtid mode 
gtid_mode = ON
enforce_gtid_consistency = ON
log_bin= mysql-bin
log_slave_updates = ON 
innodb_use_native_aio = 0

rpl_semi_sync_master_enabled = 1  
rpl_semi_sync_master_timeout = 10000   
rpl_semi_sync_slave_enabled = 1

step 3.
/****
initialize mysql and get temp root password 
user: mysql
****/


/usr/sbin/mysqld --initialize --user=mysql  --basedir=/usr   --datadir=/var/lib/mysql    --socket=/var/lib/mysql/mysql.sock

