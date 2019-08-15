docker rm -f jenkins
docker rmi qianchun27/jenkins:2.189
docker build -t qianchun27/jenkins:2.189 -f Dockerfile .
docker run --privileged -t -d -p 8082:8080 --name jenkins qianchun27/jenkins:2.189 /usr/sbin/init;
docker network connect wind_net jenkins
docker exec -it jenkins /bin/bash
