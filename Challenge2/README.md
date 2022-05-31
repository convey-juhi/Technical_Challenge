**EC2 Metadata in JSON Format**

This script needs to be executed from inside an AWS EC2 instance and expects 'Python3' to be pre-installed.

This script can be used to get the meta-data of an EC2 instance in JSON format.

User can also fetch the value for a particular key by passing the key as an input parameter to this script.

Command to run the Script :

**python3 ec2-metadata.py**

Enter 'null' to print the complete meta-data in JSON format. OR
Enter the specific key to get its value.
