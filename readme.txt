What is this?
This is a script to get passwords of previously connected wifis
------------
requirements
------------
Chrome Developer Mode on
You will need to have connected to the wifi before

------------
explanation
------------
wifi data including passwords is stored in your shill.profile, to get there its pretty easy but you dont wanna keep going back and fourth in a terminal.
the script uses the shill.profile and only shows you the decrypted password (since chrome OS encrypts it using ROT47 encoding.)


Usage

-Open terminal
-Shell
-sudo find  /home/root/ -name shill.profile -exec cp {} /tmp/ \;
-sudo chmod 644 /tmp/shill.profile
**executing script**
this part may vary
you can either do
-sh wifi.sh -f /tmp/shill.profile (using the -f parameter to specify the wifi password file)
if that does not work you will need to cd into your downloads folder
that'll be **cd /home/chronos/user/Downloads/**
