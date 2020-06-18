#define password file
PASSWD_FILE="/tmp/shill.profile"

#define scripter 
SCRIPTER=Woke
#version
VERSION=1.0


usage () {
	echo "Chrome OS Wifi Decoder"
	echo ""
	echo "First, from the shell, copy the wifi password file"
	echo "sudo find  /home/root/ -name shill.profile -exec cp {} /tmp/ \\;"
	echo "sudo chmod 644 /tmp/shill.profile"
	echo " " 
	echo "Usage:"
	echo "	$0 -f <password file> (default is /tmp/shill.profile)"
	echo "	-h  shows this help"
	echo "  "
	echo "Scripter: $SCRIPTER"
	echo "Version: $VERSION"
	exit 1
}


#check that the wan has been passed
if [ $# -eq 0 ]; then
	usage
	exit 1
fi


DEBUG=0
numopts=0
while getopts "?hdf:" options; do
  case $options in
    f ) PASSWD_FILE=$OPTARG
    	numopts=$((numopts+2));;
    d ) DEBUG=1
		numopts=$((numopts+1));;
    h ) usage;;
    \? ) usage
         exit 1;;
    * ) usage
    	 exit 1;;
  esac
done

#remove the options as cli arguments
shift $((numopts))

#check that there are no arguments left
if [ $# -ne 0 ]; then
	usage
	exit 1
fi

#1 user on chromebook
if [ $DEBUG -eq 1 ]; then
	egrep 'Name=|=rot' "$PASSWD_FILE" | sed -r 's;.*rot47:([^ ]+).*;\1;' | grep -v 'rot47'
fi

#1 more users
DATA=$(egrep 'Name=|=rot' "$PASSWD_FILE"  | sed -r 's;.*rot47:([^ ]+).*;\1;' | grep -v 'rot47' | sed 's; ;^;g')
for item in $DATA
do
	field=$(echo "$item" | grep 'Name=')
	if [ ! -z "$field" ]; then
		echo "$item" | tr '^' ' '
	else
		#decode rot47/colorizing password(s)
		echo "$item" | tr '!-~' 'P-~!-O' | grep --color '.*'
	fi
done


echo "Created by $SCRIPTER"
echo "Woke 774#4817"