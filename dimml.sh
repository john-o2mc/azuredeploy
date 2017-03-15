# Install prerequisites
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk unzip

# Setup environment
JAVAMX=`cat /proc/meminfo | grep MemTotal | awk '{printf "%1.0f", $2/1024*0.85-192}'`
JAVAMS=$((JAVAMX/5*2))
export JAVA_OPTS="-Dhost=$1 -Dpartner=$2 -Dtoken=$3 -Dfile.encoding=UTF-8 -server -Xms$((JAVAMS))m -Xmx$((JAVAMX))m -XX:MaxPermSize=128m -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -Dsun.net.inetaddr.ttl=30 -XX:+CMSIncrementalMode -XX:+CMSClassUnloadingEnabled"

# Import DimML files
cd /opt
sudo rm -rf dimml
sudo wget --output-document dimml.zip "https://dimmlarm.blob.core.windows.net/dimml-arm-template/dimml-docker.zip?st=2017-01-01T00%3A00%3A00Z&se=2018-01-01T00%3A00%3A00Z&sp=rl&sv=2015-12-11&sr=b&sig=foDZAfU04GU5IKlUWcW%2BYlIflsy7Mw6n7v8bNVNPa6k%3D"
sudo unzip dimml.zip -d dimml
sudo rm -f dimml.zip

# Optionally prefill Maven repository
if [ ! -d /root/.m2/repository ]; then
	cd /opt/dimml
    sudo cp -r maven /root/.m2
	sudo rm -rf maven
fi

# Run DimML
cd /opt/dimml
sudo chmod +x bin/dimml
ulimit -n 65536
sudo --preserve-env bin/dimml
