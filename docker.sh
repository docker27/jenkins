docker rm -f jenkins_lastest
docker rmi jenkins:lastest
docker build -t jenkins:lastest -f Dockerfile .
docker run --privileged -t -d -p 8083:8083 --name jenkins_lastest jenkins:lastest /usr/sbin/init;
docker network connect wind_net jenkins_lastest

#docker exec -it jenkins /bin/bash
