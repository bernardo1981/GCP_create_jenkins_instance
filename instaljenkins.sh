#!/bin/bash

# Variables
JENKINS_HOME="/var/lib/jenkins"
JENKINS_LOG="/var/log/jenkins/jenkins.log"
JENKINS_PORT=8080

# Update and Upgrade System Packages
echo "Updating and upgrading system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java (OpenJDK 11)
echo "Installing OpenJDK 11..."
sudo apt-get install -y openjdk-11-jdk

# Add Jenkins Repository
echo "Adding Jenkins repository..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary > /etc/apt/sources.list.d/jenkins.list'

# Update Package List and Install Jenkins
echo "Updating package list and installing Jenkins..."
sudo apt-get update -y
sudo apt-get install -y jenkins

# Start Jenkins Service
echo "Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins Status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager

# Get Initial Admin Password
echo "Retrieving Jenkins initial admin password..."
JENKINS_PASSWORD=$(sudo cat $JENKINS_HOME/secrets/initialAdminPassword)
echo "Jenkins initial admin password:"
echo $JENKINS_PASSWORD

# Log Jenkins Access Details
echo "Jenkins has been installed and started. Access Jenkins at http://$(hostname -I | awk '{print $1}'):$JENKINS_PORT"
echo "Initial admin password: $JENKINS_PASSWORD" > $JENKINS_LOG

# Print Completion Message
echo "Jenkins installation and setup complete. Check $JENKINS_LOG for details."

# End of Script
