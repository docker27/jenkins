docker rm -f jenkins_lastest
docker rmi qianchun27/jenkins:lastest
docker build -t qianchun27/jenkins:lastest -f Dockerfile .
docker run --privileged -t -d -p 8083:8083 --name jenkins_lastest qianchun27/jenkins:lastest /usr/sbin/init;
docker network connect wind_net jenkins_lastest
docker exec -it jenkins_lastest /bin/bash
