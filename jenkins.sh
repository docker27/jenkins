#!/bin/bash
downloan_url='https://mirrors.tuna.tsinghua.edu.cn/jenkins/redhat/jenkins-2.189-1.1.noarch.rpm';
downloan_file_name='jenkins-2.189-1.1.noarch.rpm';
jenkins_md5='67cdc6714a066de6992de6de8ccf260f'
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
	chown -R dev:dev /usr/lib/jenkins/
	echo "jenkins install success !!!"
}

# start
function _start() {
	su - dev -c 'nohup java -Dhudson.util.ProcessTree.disable=true -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8080 --prefix=/jenkins &' 
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
	echo "su - dev -c 'java -Dhudson.util.ProcessTree.disable=true -jar /usr/lib/jenkins/jenkins.war --ajp13Port=-1 --httpPort=8080 --prefix=/jenkins &'" >> /etc/rc.d/init.d/jenkins
	chkconfig --add jenkins
	echo "chkconfig add jenkins success"
}
function _clean() {
	rm -rf /opt/install/
}

_init
_install
_start
_chkconfig
_clean
