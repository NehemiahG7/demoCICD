apt-get update

apt-get -y install \
    default-jre \
     default-jdk

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins

systemctl start jenkins
temp=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)