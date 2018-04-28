##
# signames.sh from Lsyncd -- the Live (Mirror) Syncing Demon
#
# Creates a .lua file for all signal names understood by the kill command
# on the system Lsyncd is being compiled for.
#
# This script has been tested with bash and dash.
#
# License: GPLv2 (see COPYING) or any later version
# Authors: Axel Kittenberger <axkibe@gmail.com>
#
KILL=/bin/kill

# Don't know a better way, checks only until this signal number
# To quote, this ought to be enough for anybody.
nmax=256

if [ "$#" -ne 1 ];
then
	echo >&2 "$0 needs excatly one argument -- the lua file to create"
	exit 1
fi

if ! [ "$BASH_VERSION" = '' ];
then
	echoe=-e
fi

echo "-- This file is autogenerated by $0 querying `$KILL --version`" > $1
echo "signames =" >> $1
echo "{" >> $1

n=1
while name=`$KILL --list=$n 2>/dev/null`;
do
	if ! [ -z $name ]
	then
		echo $echoe "\t[ $n ] = '$name'," >> $1
	fi
	n=$(( n + 1 ))
	if [ $n -gt $nmax ]; then break; fi
done

echo "}" >> $1
