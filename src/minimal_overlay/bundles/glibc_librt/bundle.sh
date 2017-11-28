#!/bin/sh

SRC_DIR=$(pwd)

. ../../common.sh

if [ ! -d $SYSROOT ] ; then
  echo "Cannot continue - GLIBC is missing. Please buld GLIBC first."
  exit 1
fi

mkdir -p "$WORK_DIR/overlay/$BUNDLE_NAME"
cd $WORK_DIR/overlay/$BUNDLE_NAME

DESTDIR="$PWD/${BUNDLE_NAME}_installed"

rm -rf $DESTDIR

mkdir -p $DESTDIR/lib
cp $SYSROOT/lib/librt.so.1 $DESTDIR/lib/
ln -s librt.so.1 $DESTDIR/lib/librt.so

echo "Reducing $BUNDLE_NAME size"
strip -g $DESTDIR/lib/*

ROOTFS="$WORK_DIR/src/minimal_overlay/rootfs"

cp -r $DESTDIR/* $ROOTFS

echo "$BUNDLE_NAME has been installed."

cd $SRC_DIR