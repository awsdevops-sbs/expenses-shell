source common.sh

print "install sql"
systemctl enable mysqld &>>/tmp/exp.log
 echo $?

print "start MySQl"
systemctl start mysqld &>>/tmp/exp.log
 echo $?

sudo mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/exp.log
 echo $?