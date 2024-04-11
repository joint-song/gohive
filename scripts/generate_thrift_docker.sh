#!/bin/bash

THRIFT_VER="0.10.0"
THRIFT_IMG="thrift:$THRIFT_VER"
THRIFT="docker run -v "${PWD}:/data" --platform linux/amd64 $THRIFT_IMG thrift"
THRIFT_GEN_DIR=gen-go
THRIFT_GO_ARGS=thrift_import="github.com/apache/thrift/lib/go/thrift"

$THRIFT -o /data -r --gen go:$THRIFT_GO_ARGS --out /data/$THRIFT_GEN_DIR /data/thrift/HiveServer.thrift

cp -r gen-go/hiveserver .

# For some reason these files have to be deleted. Getting duplicate definition
rm hiveserver/tcliservice.go hiveserver/ttypes.go hiveserver/constants.go

# This file we don't need
rm -rf hiveserver/t_c_l_i_service-remote/
