#!/bin/bash
echo "####该脚本使用官方API下载优学院直播平台PPT(图片),AUTO_ID需自行控制台抓包获取####"
if [ $# -eq 0 ];then
    echo "未提供平台AUTOID"
    exit 1
fi
API_URL="https://doc-2.polyv.net/data/"
AUTO_ID=$1
#获取ppt目录文件
echo "正在下载PPT目录文件:"$API_URL$AUTO_ID.json" -> /tmp/"$AUTO_ID".json"
if [ ! -e "/tmp/$AUTO_ID.json" ];then
    /usr/bin/curl $API_URL$AUTO_ID.json > /tmp/$AUTO_ID.json
fi
#获取文件信息
FILE_NAME=$(cat /tmp/$AUTO_ID.json | jq ".fileName" | sed 's/\"//g' | sed 's/\ //g')
PAGES=$(cat /tmp/$AUTO_ID.json | jq ".totalPage")
FILE_URL=$(cat /tmp/$AUTO_ID.json | jq ".convertFileJson.images" | sed 's/\[//g' | sed 's/\]//g' | sed $
echo "下载:"$FILE_NAME":"$PAGES"页 -> "$(pwd)/$FILE_NAME/
#开始下载
mkdir $(pwd)/$AUTO_ID$FILE_NAME
cd $(pwd)/$AUTO_ID$FILE_NAME
#创建临时下载文件
echo $FILE_URL | tr "," "\n" > /tmp/$AUTO_ID.log
wget -i /tmp/$AUTO_ID.log
cd ..
echo "下载完成"
