LOG=/tmp/exp.log

print(){
 echo $1
  echo "############### $1 ###############" &>>$LOG

  }

  check_status(){

    if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
    else
    echo -e "\e[31mFailure\e[0m"
  fi
  }

  app_req() {

  print "Clean the Old Content"
  rm -rf ${app_dir}/* &>>$LOG
   check_status $?

  print "Create App Directory"
  mkdir ${app_dir} &>>$LOG
   check_status $?

   print "Download App components"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
   check_status $?

  print "extract app components"
  unzip /tmp/${component}.zip &>>$LOG
   check_status $?

  }