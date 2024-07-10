sudo apt update

echo "Install jdk 17"

sudo apt install openjdk-17-jre-headless -y

$ dpkg -s java &> /dev/null
if [ $? -eq 0 ]; then
    echo "java is installed!"
else
    echo "java is NOT installed!"
fi

echo "Install Jenkins"

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

$ dpkg -s jenkins &> /dev/null
if [ $? -eq 0 ]; then
    echo "Jenkins is installed!"
else
    echo "Jenkins is NOT installed!"
fi

echo "Install terraform"

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y

$ dpkg -s terraform &> /dev/null
if [ $? -eq 0 ]; then
    echo "terraform is installed!"
else
    echo "terraform is NOT installed!"
fi