## Setting up agent pool
```
wget https://download.agent.dev.azure.com/agent/4.261.0/vsts-agent-linux-x64-4.261.0.tar.gz
~/$ mkdir myagent && cd myagent
mkdir myagent && cd myagent
pwd
tar -xvzf /home/azureuser/vsts-agent-linux-x64-4.261.0.tar.gz
ls
~/myagent$ ./config.sh
./config.sh
./run.sh
sudo ./svc.sh install azureuser
cat svc.sh 
sudo ./svc.sh start
sudo ./svc.sh status
history -w /dev/stdout
history | cut -c 8-

sudo ./svc.sh uninstall
```
