/***
there are several options(onl linux here) we can choose for running vitess:  Redhat, Oracle Linux, CentOS, Debian, Ubuntu. 
for me, the company which I am woring with only uses Oracle Linux, so I use it ot setup Vitess. 
please use root to finish following steps.  
****/

Step 1. 
/****
installing Oracle Linux 7.6 from scatch , please refer to official doc. 
****/


Step 2. 
/****
disable IPV6 : I tried a lot of time to execute the first script 101_initial_cluster.sh ,and foud vitess listens both IPV4 and IPV6 port , 
and Vitess other part only access IPV4 port. 

ash-4.2$ netstat -lnt
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.1:47814         0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:199           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:17100           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:17101           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:17102           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN
tcp        0      0 10.87.200.72:28883      0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:21811           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:21812           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:21813           0.0.0.0:*               LISTEN
tcp        0      0 192.168.42.1:53         0.0.0.0:*               LISTEN
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
tcp        0      0 10.87.200.72:38881      0.0.0.0:*               LISTEN
tcp        0      0 10.87.200.72:38882      0.0.0.0:*               LISTEN
tcp        0      0 10.87.200.72:38883      0.0.0.0:*               LISTEN
tcp6       0      0 :::16101                :::*                    LISTEN
tcp6       0      0 :::16102                :::*                    LISTEN
tcp6       0      0 :::2224                 :::*                    LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 :::15000                :::*                    LISTEN
tcp6       0      0 :::15100                :::*                    LISTEN
tcp6       0      0 :::15101                :::*                    LISTEN
tcp6       0      0 :::15102                :::*                    LISTEN
tcp6       0      0 :::15999                :::*                    LISTEN
tcp6       0      0 :::16100                :::*                    LISTEN
bash-4.2$

****/


vi /etc/sysctl.conf      

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.wlp0s26f7u1.disable_ipv6 = 1
net.ipv6.conf.enp0s25.disable_ipv6 = 1


step 3.
/**** 
modify grub.cfg  , add:  ipv6.disable=1 to startup parameter 
****/

cp  /boot/grub2/grub.cfg /boot/grub2/grub.cfg.bkk
vi /etc/default/grub
GRUB_CMDLINE_LINUX="rd.lvm.lv=ol/root rd.lvm.lv=ol/swap rhgb quiet ipv6.disable=1"

step 4.
/****
generate cfg file 
****/

grub2-mkconfig -o /boot/grub2/grub.cfg

step 5. 
/****
disable selinux , fire wall 
****/
systemctl disable  firewalld
systemctl stop firewalld

vi /etc/selinux/config
SELINUX=disabled


step 6. 
/****
add user:  mysql ,  due to PAM , we must use login system with GUI, and add user manually. 
****/
login system with GUI , and add user mysql 

step 7. 
reboot 

