#!/bin/bash

source ./common.sh

check_root

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
VALIDATE $? "Adding RabbitMQ repo"

dnf install rabbitmq-server -y &>>$LOG_FILE       # install rabbitmq
VALIDATE $? "Installing RabbitMQ Server"

systemctl enable rabbitmq-server &>>$LOG_FILE     # systemctl enable
VALIDATE $? "Enabling RabbitMQ Server"

systemctl start rabbitmq-server &>>$LOG_FILE      # systemctl start
VALIDATE $? "Starting RabbitMQ"
 
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE                      # add user in rabbitmq broker
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE       # permissions add to user

VALIDATE $? "Setting up permissions"

print_total_time