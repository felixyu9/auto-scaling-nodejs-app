#!/bin/bash -ex
# output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# download nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# source nvm
. /.nvm/nvm.sh
# install node
nvm install node
#export NVM dir
export NVM_DIR="/.nvm"	
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"	
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
#upgrade yum
sudo yum upgrade
#install git
sudo yum install git -y
cd /home/ec2-user
# get source code from githubt
git clone https://github.com/felixyu9/auto-scaling-nodejs-app
#get in project dir
cd auto-scaling-nodejs-app
#give permission
sudo chmod -R 755 .
#install node module
npm install
# start the app
node app.js > app.out.log 2> app.err.log < /dev/null &