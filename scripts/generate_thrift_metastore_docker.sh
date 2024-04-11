#!/bin/bash

PROJECT_ROOT="github.com/joint-song/gohive"
THRIFT_VER="0.10.0"
THRIFT_IMG="thrift:$THRIFT_VER"
THRIFT="docker run -v "${PWD}:/data" --platform linux/amd64 $THRIFT_IMG thrift"
THRIFT_GEN_DIR=gen-go
THRIFT_GO_ARGS=thrift_import="github.com/apache/thrift/lib/go/thrift"

$THRIFT -o /data -r --gen go:$THRIFT_GO_ARGS --out /data/$THRIFT_GEN_DIR /data/thrift/hive_metastore.thrift

sed -i '' 's|"fb303"|'"\"$PROJECT_ROOT/fb303\""'|g' $THRIFT_GEN_DIR/hive_metastore/*.go
sed -i '' 's|"fb303"|'"\"$PROJECT_ROOT/fb303\""'|g' $THRIFT_GEN_DIR/hive_metastore/thrift_hive_metastore-remote/*.go
sed -i '' 's|"hive_metastore"|'"\"$PROJECT_ROOT/hive_metastore\""'|g' $THRIFT_GEN_DIR/hive_metastore/thrift_hive_metastore-remote/*.go

cp -r gen-go/hive_metastore .
cp -r gen-go/fb303 .
