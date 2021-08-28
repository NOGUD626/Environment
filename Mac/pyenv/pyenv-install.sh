#!/bin/sh
# pyenv-virtualenvのセットアップ
# git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

profile_path=/.zshrc
FILE=$HOME$profile_path
#  zshかもしくはbashかの判断
if [ $SHELL = "/bin/zsh" ]; then
if grep 'eval "$(pyenv virtualenv-init -)"' ${FILE} >/dev/null; then
 echo ""
else
 echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
fi
else
if grep 'eval "$(pyenv virtualenv-init -)"' ${FILE} >/dev/null; then
 echo ""
else
 echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
fi
fi

# pyenvを実行
CPPFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(brew --prefix zlib)/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"
pyenv install 3.8.2
pyenv install 3.9.0
pyenv global 3.9.0

exec "$SHELL" --login