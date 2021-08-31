read -sp "Password: " pass

# インストール前のアップデート作業
echo ${pass} | sudo -S apt -y install apt update
echo ${pass} | sudo -S apt -y install apt upgarde

# open ldapのインストール
echo ${pass} | sudo -S apt -y install slapd ldap-utils

# open ldapの設定
echo ${pass} | sudo -S dpkg-reconfigure slapd

mkdir $HOME"/open_ldap_init"
touch $HOME"/open_ldap_init/base.ldif"

# base.ldifファイルの作成
SETTING=$(sudo slapcat | grep -o -E "^dn\:(.)+" | head -n1 | sed -e "s/dn: //")
cat << EOF > $HOME"/open_ldap_init/base.ldif"
dn: ou=people,${SETTING}
objectClass: organizationalUnit
ou: people

dn: ou=groups,${SETTING}
objectClass: organizationalUnit
ou: groups
EOF

# base.ldifファイルの反映
echo ${pass} | sudo -S ldapadd -x -D cn=admin,$SETTING -W -f $HOME"/open_ldap_init/base.ldif"

# LDAPサーバーのユーザーパスワードの設定
PASSWORD=$(sudo slappasswd)

touch $HOME"/open_ldap_init/ldapuser.ldif"

# dapuser.ldifファイルの作成
cat << EOF > $HOME"/open_ldap_init/ldapuser.ldif"
dn: uid=ubuntu,ou=people,${SETTING}
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: ubuntu
sn: ubuntu
userPassword: ${PASSWORD}
loginShell: /bin/bash
uidNumber: 2000
gidNumber: 2000
homeDirectory: /home/ubuntu

dn: cn=ubuntu,ou=groups,${SETTING}
objectClass: posixGroup
cn: ubuntu
gidNumber: 2000
memberUid: ubuntu
EOF

# dapuser.ldifファイルの反映
echo ${pass} | sudo -S ldapadd -x -D cn=admin,$SETTING -W -f $HOME"/open_ldap_init/ldapuser.ldif"

# ldap manager関連のインストールと設定
echo ${pass} | sudo -S apt -y install apache2
echo ${pass} | sudo -S apt -y install php libapache2-mod-php
echo ${pass} | sudo -S apt -y install ldap-account-manager

VERSION=$(ls -1 /etc/php)

PHP_INITIALIZE="/etc/php/"${VERSION}"/apache2/php.ini"

# PHPのメモリ上限を128Mに変更
sudo sed -i -e "/^ *memory_limit =/c\memory_limit =128M" $PHP_INITIALIZE

SETTING=$(sudo slappasswd)