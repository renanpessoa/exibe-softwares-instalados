#!/bin/bash

<<'INFO'
    
    Autor:  Renan Pessoa
    E-Mail: renanhpessoa@gmail.com
    Sobre:  Script desenvolvido para informar as versões dos softwares instalados no servidor.

INFO

<<'CHANGELOG'

    1.0 - 19 Setembro 2016 [ Autores: Renan Pessoa ]
        * Versão inicial

CHANGELOG

echo -e  "\e[90mVersão 1.0 - (renanhpessoa@gmail.com)\e[0;00m\n";

#. cPanel .#
cpanelv=$(/usr/local/cpanel/cpanel -V);

#. Verifica CloudLinux .#
if [[ ! -z `cat /etc/redhat-release | grep -i Cloudlinux` ]]; then
    
    #. CloudLinux .#
    cloudlinuxv=$(echo "\`Instalado\`");

    #. CageFS .#
    cagefsv=$(/usr/sbin/cagefsctl --cagefs-status 2>/dev/null | grep -i enabled >/dev/null && echo "\`Instalado\`");

    #. PHP Selector .#
    phpselectorv=$(selectorctl --list 2>/dev/null | grep php >/dev/null && echo "\`Instalado\`");
fi

#. Sistema Operacional .#
so=$(lsb_release -d | cut -d: -f2 | sed 's/release//;s/\t//;s/  / /');

#. MySQL .#
mysqlv=$(mysql -V 2>/dev/null | awk '{print $5}' | tr -d ',');

#. PostgreSQL .#
pgsqlv=$(psql --version 2>/dev/null | grep psql | awk '{print $3}');

#. Apache .#
apachev=$(httpd -v 2>/dev/null | grep version | cut -d'/' -f2 | awk '{print $1}');

#. Nginx .#
pat=$(which nginx 2>/dev/null|| >/dev/null); 

if [[ ! -z $pat ]];then
    $pat -v 2>/tmp/nginxv.txt;
    nginxv=$(cat /tmp/nginxv.txt 2>/dev/null | cut -d'/' -f2 );
fi
rm -fr /tmp/nginxv.txt 2>/dev/null

#. PHP .#
phpv=$(php -v 2>/dev/null | grep "built" | awk '{print $2}');

#. PHP Módulos .#
phpm=$(php -m | egrep -v "(\[|\()" | sort | uniq | xargs -n 20);

#. Handler do PHP .#
phphanlder=$(/usr/local/cpanel/bin/rebuild_phpconf --current | grep -i php5 | awk '{print $3}');

#. CSF .#
csfv=$([ -e /etc/csf/csf.conf ] && echo -e "\`Instalado\`");
portas=$(egrep "^TCP_|{IN,OUT}" /etc/csf/csf.conf 2>/dev/null);

#. Softwares de terceiros .#
lista_softwares=$(whmapi1 get_appconfig_application_list | grep displayname | egrep -iv "(ConfigServer|View Bandmin|nginx|\!|GlobalSoft)" | cut -d: -f2 | sort | uniq)

#. Fantástico .#
fantasticov=$(echo -e "${lista_softwares[@]}" | grep -i fantastico >/dev/null && echo "\`Instalado\`");

#. Softaculous .#
softaculousv=$(echo -e "${lista_softwares[@]}" | grep -i softaculous >/dev/null && echo "\`Instalado\`");

#. WHMXtra .#
whmxtrav=$(echo -e "${lista_softwares[@]}" | grep -i xtra >/dev/null && echo "\`Instalado\`");

#. RvSKIN .#
rvskinv=$(echo -e "${lista_softwares[@]}" | grep -i rvskin >/dev/null && echo "\`Instalado\`");

#. WHMSonic .#
whmsonicv=$([ -e /usr/local/cpanel/whostmgr/docroot/whmsonic ] && echo -e "\`Instalado\`");

#. Presence Builder .#
presencev=$([ -e /usr/local/cpanel/base/frontend/x3/webpresencebuilder ] && echo -e "\`Instalado\`");

echo -e "
| Software    \t\t| Versão/Status | 
| :-------------: \t|:-------------:| 
| cPanel \t\t| $cpanelv | 
| Sistema Operacional \t| $so     | 
| CloudLinux \t\t| ${cloudlinuxv:-"*Não Instalado*"}     | 
| CageFS \t\t| ${cagefsv:-"*Não Instalado*"}     | 
| PHPSelector \t\t| ${phpselectorv:-"*Não Instalado*"}     | 
| MySQL \t\t| ${mysqlv:-"*Não Instalado*"}     | 
| PostgreSQL \t\t| ${pgsqlv:-"*Não Instalado*"}     | 
| Apache \t\t| ${apachev:-"*Não Instalado*"}     | 
| Nginx \t\t| ${nginxv:-"*Não Instalado*"}     |
| PHP \t\t| \t  ${phpv:-"*Não Instalado*"}     |
| PHP Handler \t\t| ${phphanlder:-"*Não Instalado*"}     |  
| CSF \t\t| \t  ${csfv:-"*Não Instalado*"}     | 
| Fantástico \t\t| ${fantasticov:-"*Não Instalado*"}     | 
| Softaculous \t\t| ${softaculousv:-"*Não Instalado*"}     | 
| WHMXtra \t\t| ${whmxtrav:-"*Não Instalado*"}     | 
| WHMSonic \t\t| ${whmsonicv:-"*Não Instalado*"}     | 
| RvSkin \t\t| ${rvskinv:-"*Não Instalado*"}     |
| Presence Builder \t| ${presencev:-"*Não Instalado*"}     |
* Módulos do PHP
\`\`\`
$phpm
\`\`\`
" | tee software.txt

if [[ ! -z $portas ]];then
    echo -e "* Portas do CSF
\`\`\` 
$portas 
\`\`\`" | tee -a software.txt
fi

#. Remove o markdown do arquivo .#
sed -i 's/|/ /g;s/```/---------------------------------------------------------/;s/`//g;s/\*//g' software.txt

echo -e "\nAs informações acima sem o markdown está no arquivo $PWD/software.txt"
