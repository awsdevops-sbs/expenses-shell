dnf install mysql-server -y &>>/tmp/exp.log

systemctl enable mysqld &>>/tmp/exp.log
systemctl start mysqld &>>/tmp/exp.log

sudo mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/exp.log