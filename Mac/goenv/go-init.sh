#!/bin/sh
# Go envをHomebrew経由でインストール
brew install --HEAD goenv

#  zshかもしくはbashかの判断
FILE=$HOME
if [ $SHELL = "/bin/zsh" ]; then
FILE=$FILE"/.zshrc"
echo 'export GOENV_ROOT=$HOME/.goenv' >> $FILE
echo 'export PATH=$GOENV_ROOT/bin:$PATH' >> $FILE
echo 'eval "$(goenv init -)"' >> $FILE
else
FILE=$FILE"/.bash_profile"
echo 'export GOENV_ROOT=$HOME/.goenv' >> $FILE
echo 'export PATH=$GOENV_ROOT/bin:$PATH' >> $FILE
echo 'eval "$(goenv init -)"' >> $FILE
fi
echo "Go env initialize finish."
echo ${pass} | sudo -S source ~/.zshrc