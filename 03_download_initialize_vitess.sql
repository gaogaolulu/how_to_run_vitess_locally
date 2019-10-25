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
modify 
