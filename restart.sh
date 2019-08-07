#!/bin/bash

pid=`ps -ef|grep -w 'jenkins'|grep -v grep|cut -c 9-15`
if [ $pid ]; then
	su - dev -c "kill -9 $pid"
	echo "kill pid : $pid"
fi
su - dev -c "java -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8080 --prefix=/jenkins &"
echo "start jenkins success"