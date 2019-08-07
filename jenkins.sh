#!/bin/bash
downloan_url='https://pkg.jenkins.io/redhat-stable/jenkins-2.107.3-1.1.noarch.rpm';
downloan_file_name='jenkins-2.107.3-1.1.noarch.rpm';
function _init() {
	mkdir -p /opt/jenkins/.jenkins
	chown -R dev:dev /opt/jenkins/
}

# install
function _install() {
	jenkins_is_install=`rpm -qa | grep jenkins |wc -l`
	if [ $jenkins_is_install == 0 ];then
		rpm -ivh /opt/install/${downloan_file_name}
	fi
	echo "jenkins install success !!!"
}

# start
function _start() {
	nohup java -Dhudson.util.ProcessTree.disable=true -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8083 --prefix=/jenkins &  
	echo "start jenkins success !!!"
}

# chkconfig
function _chkconfig() {
	cd /etc/rc.d/init.d/
	rm -rf /etc/rc.d/init.d/jenkins 
	touch /etc/rc.d/init.d/jenkins
	chmod +x /etc/rc.d/init.d/jenkins
	echo '#!/bin/bash' >> /etc/rc.d/init.d/jenkins
	echo '# chkconfig: 12345 95 05' >> /etc/rc.d/init.d/jenkins

	echo 'export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64/' >> /etc/rc.d/init.d/jenkins
	echo 'export MAVEN_HOME=/usr/local/maven/apache-maven-3.5.4' >> /etc/rc.d/init.d/jenkins
	echo 'export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin' >> /etc/rc.d/init.d/jenkins
	echo 'export JENKINS_HOME=/opt/jenkins/.jenkins' >> /etc/rc.d/init.d/jenkins
	
	echo "su - dev -c 'java -Dhudson.util.ProcessTree.disable=true -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8082 --prefix=/jenkins &'" >> /etc/rc.d/init.d/jenkins
	chkconfig --add jenkins
	echo "chkconfig add jenkins success"
}

_init
_download
_install
_start
_chkconfig
