# fcserver_openwrt
fcserver push install on openwrt.

HOW-TO:

clone repository onto local hdd 
  $ git clone https://github.com/shirleyquirk/fcserver_openwrt
  
navigate to folder
  $ cd fcserver_openwrt/
  
copy ssh-id of the device to be installed on eg
  $ ssh-copy-id root@192.168.8.1
  
run install script 
  $ ./install.sh root@192.168.8.1
  
check if the server is running on the target device in browser
  $ 192.168.8.1:7890
  
modify json.config if nessessary
  
  


