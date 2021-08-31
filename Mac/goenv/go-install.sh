read -sp "Password: " pass

# Shell自身のパスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo $SCRIPT_DIR/go-init.sh

# Goenvのインストール作業
export pass
sh $SCRIPT_DIR/go-init.sh

# サブコマンドが終わるのを待つ
wait

# Goのバージョンを確認
goenv -v

GO_VERSION=$(goenv install -l | grep -o -E "(\d+\.)+(\d){1,2}$" | tail -n 1)
goenv install $GO_VERSION

goenv global $GO_VERSION

#  zshかもしくはbashかの判断
FILE=$HOME
if [ $SHELL = "/bin/zsh" ]; then
FILE=$FILE"/.zshrc"
echo 'export GOPATH=$HOME/go' >> $FILE
echo 'PATH=$PATH:$GOPATH/bin' >> $FILE
source ~/.zshrc
else
FILE=$FILE"/.bash_profile"
echo 'export GOPATH=$HOME/go' >> $FILE
echo 'PATH=$PATH:$GOPATH/bin' >> $FILE
source ~/.bash_profile
fi

