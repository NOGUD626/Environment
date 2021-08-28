#!/bin/sh

# 初期セットアップ
# read -sp "Password: " pass
# echo $pass | sudo -S chown -R $(whoami) /usr/local/lib/pkgconfig

#出力が不要の場合は
# echo パスワード | sudo -S コマンド > /dev/null 2>&1

# nodebrewコマンドがない場合はインストール
if !(type "nodebrew" > /dev/null 2>&1); then
    brew install nodebrew
    echo "実行"
fi

# nodebrew -v

#  zshかもしくはbashかの判断
FILE=$HOME
if [ $SHELL = "/bin/zsh" ]; then
    FILE=$FILE"/.zprofile"
    COMMND='export PATH=$HOME/.nodebrew/current/bin:$PATH'
    cat << EOF >> ${FILE}
$COMMND
EOF
else
    FILE=$FILE"/.bash_profile"
    COMMND='export PATH=$HOME/.nodebrew/current/bin:$PATH'
    cat << EOF >> ${FILE}
$COMMND
EOF
fi

exec $SHELL -l