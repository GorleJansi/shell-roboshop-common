#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo       #  mongo-clinet repo added
VALIDATE $? "Copy mongo repo"

dnf install mongodb-mongosh -y &>>$LOG_FILE                       #  mongo-clinet installed
VALIDATE $? "Install MongoDB client"

INDEX=$(mongosh mongodb.jansi1.site --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")      #  mongo check if loaded
if [ $INDEX -le 0 ]; then
    mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "Loading $app_name products"
else
    echo -e "$app_name products already loaded ... $Y SKIPPING $N"
fi

app_restart
print_total_time