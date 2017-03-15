# Install Docker
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl enable docker

# Import DimML files
sudo apt-get install -y unzip
mkdir --parents /home/dimml/src/dimml-docker
cd /home/dimml/src/dimml-docker/
wget --output-document dimml-docker.zip "https://dimmlarm.blob.core.windows.net/dimml-arm-template/dimml-docker.zip?st=2017-01-01T00%3A00%3A00Z&se=2018-01-01T00%3A00%3A00Z&sp=rl&sv=2015-12-11&sr=b&sig=foDZAfU04GU5IKlUWcW%2BYlIflsy7Mw6n7v8bNVNPa6k%3D"
unzip dimml-docker.zip
rm dimml-docker.zip

# Create Docker image and container
sudo /usr/bin/docker build --tag dimml-docker .
chmod +x create.sh /home/dimml/src/dimml-docker/dimml/bin/dimml
./create.sh

# Start DimML
sudo /usr/bin/docker start dimml
