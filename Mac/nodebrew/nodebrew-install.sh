#!/bin/sh

# profileファイルが存在しない場合は作成
FILE=$HOME"/.nodebrew/src"
if [ ! -e $FILE ];then
  mkdir -p $FILE
fi

# 安定版インストール
VERSION=$(nodebrew install-binary stable)
VERSION=$(echo ${VERSION} | grep -o -E "^v(\d+\.)+(\d)?" | head -n1)

# インストールしたバージョンの有効化
nodebrew use $VERSION

nodebrew ls

node -v