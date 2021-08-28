#!/bin/sh
brew install pyenv
profile_path=""

#  zshかもしくはbashかの判断
if [ $SHELL = "/bin/zsh" ]; then
  profile_path="/.zprofile"
  setting_path="/.zshrc"
else
  profile_path="/.profile"
  setting_path=""
fi

# profileファイルが存在しない場合は作成
FILE=$HOME$profile_path
echo $FILE
if [ ! -e $FILE ];then
  echo "File not exists."
fi
profile_path=$HOME$profile_path

FILE=$HOME"/.pyenv"
FILE1='eval "export PATH="'${FILE}'/shims:${PATH}""'
FILE='export PYENV_ROOT="'${FILE}'"'

if grep 'export PYENV_ROOT' ${profile_path} >/dev/null; then
	echo "ファイル自体が存在します。"
else
FILE=$HOME"/.pyenv"
FILE='export PYENV_ROOT="'${FILE}'"'
cat << EOF >> ${profile_path}
${FILE}
export PATH="/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
${FILE1}
EOF
# からでなければ下記の処理を実行
if [ -n $setting_path ]; then
profile_path=$HOME$setting_path
if [ ! -e $profile_path ];then
 touch $profile_path
fi
COMMND='eval "$(pyenv init -)"'
cat << EOF >> ${profile_path}
$COMMND
EOF
fi
fi

# shellを再起動
exec $SHELL -l

# pyenvを実行
pyenv install 3.8.2
pyenv global 3.8.2