#!/bin/sh
#
# by Shigeya, March 2010
#

case $# in
7) TARGET=$1;
   OLD_DATA=$2; OLD_OBJECT=$3; OLD_FILEMODE=$4;
   NEW_DATA=$2; NEW_OBJECT=$3; NEW_FILEMODE=$4;
   OLD=$OLD_DATA; NEW=$NEW_DATA;
   ;;
2) OLD=$1; NEW=$2;
   ;;
*) echo Usage:;
   echo "  keydiff.sh OLD NEW";
   echo "  ...or 7 parameter git diff external mode";
   exit 1
   ;;
esac

TMPDIR=".tmp$$"

PWD=`pwd`
OLD_A=$PWD/$OLD
NEW_A=$PWD/$NEW

OLD_B=`basename $OLD`
NEW_B=`basename $NEW`

mkdir $TMPDIR
cd $TMPDIR;
mkdir $OLD_B $NEW_B
( cd $OLD_B; unzip -q $OLD_A)
( cd $NEW_B; unzip -q $NEW_A)
( cd $OLD_B; xmlpp index.apxl >Xindex.apxl; /bin/mv -f Xindex.apxl index.apxl)
( cd $NEW_B; xmlpp index.apxl >Aindex.apxl; /bin/mv -f Aindex.apxl index.apxl)
diff -u $OLD_B $NEW_B
/bin/rm -rf $TMPDIR

