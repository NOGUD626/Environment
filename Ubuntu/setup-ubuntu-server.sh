read -sp "Password: " pass
# パッケージの更新作業
echo ${pass} | sudo -S apt update -y
echo ${pass}  | sudo -S apt upgrade -y

# 日本語ディレクトリを英語名
LC_ALL=C xdg-user-dirs-update --force

# 日本語ディレクトリ名のものを消去
ARRAY=("ドキュメント" "ミュージック" "ダウンロード" "デスクトップ" "ビデオ" "公開" "ピクチャ") 

for item in ${ARRAY[@]}; do
    if [ -e $HOME"/"$item ]; then
        rm -rf $HOME"/"$item
        echo $item"を消去"
	fi
done

# パッケージのインストール作業
ARRAY=(git openssh-server vim)
for item in ${ARRAY[@]}; do
    if !(type ${item} > /dev/null 2>&1); then
	echo ${pass} | sudo -S apt install $item -y
	echo $item"をインストール"
    fi
done