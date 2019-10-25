/****
we can run the first bash shell file to startup vitess .. and about environment variables ..
there are some parameters which are not metioned at official doc. please be noted here. 
Oct-25-2019 
left shell files ,I reach to  
./303_horizontal_split.sh
and I will update the latest progress here .

user: mysql
****/

step 1.
/****
before we run the bash shell file, we need to setup nvironment variables

****/

vi /home/mysql/.bash_profile

export PATH=$PATH:/usr/local/go/bin
export VTROOT=/xxxx/kubernetes/vitess-release-8cdd456
export VTTOP=$VTROOT
export MYSQL_FLAVOR=MySQL56
#### vitess target directory
export VTDATAROOT=/home/mysql/vtdataroot
export PATH=${VTROOT}/bin:${PATH}
#### we need to set it to startup MySQL 5.7 which is missed in official doc.
export VT_MYSQL_BASEDIR=/usr
export VT_MYSQL_ROOT=/usr
#### if we want to user zookeeper  
#### export TOPO=zk2 
#### if we want to use etcd  
#### normally, I can't start up vitess with zookeeper.
export TOPO=


step 2.
source .bash_profile

step 3. 
/****
start up the first shell file. 
****/

cd /xxxx/kubernetes/vitess-release-8cdd456/examples/local
./101_initial_cluster.sh

step 4.
/**** 
checking status , you should not see any error message and see following sessions and processes . 
and you will not see java , zookeeper sessions here because we set:  export TOPO= 
****/

[mysql@localhost local]$ pgrep -fl vtdataroot
7132 etcd
7174 vtctld
7324 mysqld_safe
7351 mysqld_safe
7380 mysqld_safe
7420 vttablet
7421 vttablet
7422 vttablet
7573 vtgate
[mysql@localhost local]$


step 5.
/***
tring to login 
****/


ysql -h 127.0.0.1 -P 15306


step 6. 

mysql -h 127.0.0.1 -P 15306 < ../common/insert_commerce_data.sql 
./201_customer_keyspace.sh 
./202_customer_tablets.sh 
./203_vertical_split.sh
./204_vertical_migrate_replicas.sh
./205_vertical_migrate_master.sh
mysql -h 127.0.0.1 -P 15306 --table < ../common/select_commerce_data.sql
./206_clean_commerce.sh 
./301_customer_sharded.sh
#### I got error message here . 

[mysql@localhost local]$ ./303_horizontal_split.sh
enter etcd2 env
I1024 14:38:25.104112    8976 trace.go:151] successfully started tracing with [noop]
I1024 14:38:25.105404    8976 instance.go:132] Starting worker...
I1024 14:38:25.107114    8976 command.go:153] Working on: customer/0
State: error
E1024 14:38:25.107129    8976 vtworker.go:108] Code: FAILED_PRECONDITION
the specified shard customer/0 is not in any overlapping shard

failed initShardsForHorizontalResharding
init() failed
[mysql@localhost local]$



