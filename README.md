### Sobre

#### **`Este script funciona apenas em servidores cPanel/WHM`**

Este script informar se os principais softwares utilizados estão instalados no servidor e a sua devida versão. 

Ele pode ser utilizado para comparar os softwares instalados nos servidores antes de realizar uma migração para evitar problemas de incompatibilidade. 

Também pode ser utilizado para documentar os softwares presentes no servidor antes de realizar upgrade de servidor/SO. 

### Como utilizar

O script tem a saída já formatada em <b>markdown</b> basta copiar o que está na tela e colar em notas no ticket.

```

| Software    		| Versão/Status | 
| :-------------: 	|:-------------:| 
| cPanel 		| 58.0 (build 28) | 
| Sistema Operacional 	| Centos 6     | 
| CloudLinux 		| *Não Instalado*     | 
| CageFS 		| *Não Instalado*     | 
| PHPSelector 		| *Não Instalado*     | 
| MySQL 		| 5.6.31     | 
| PostgreSQL 		| 8.4.20     | 
| Apache 		| 2.4.23     | 
| Nginx 		| 1.9.14     |
| PHP 		| 	  5.6.25     |
| PHP Handler 		| suphp     |  
| CSF 		| 	  `Instalado`     | 
| Fantástico 		| `Instalado`     | 
| Softaculous 		| `Instalado`     | 
| WHMXtra 		| `Instalado`     | 
| WHMSonic 		| `Instalado`     | 
| RvSkin 		| *Não Instalado*     |
| Presence Builder 		| *Não Instalado*     |

* Módulos do PHP

bcmath calendar Core ctype curl date dom ereg filter ftp gd hash iconv imap ionCube Loader json libxml mbstring mcrypt
mysql mysqlnd openssl pcre PDO pdo_mysql pdo_sqlite Phar posix Reflection session SimpleXML sockets SPL sqlite3 standard suhosin tokenizer xml xmlreader
xmlwriter xsl Zend Guard Loader zip zlib

* Portas do CSF

TCP_IN = "20,21,22,25,26,53,80,110,143,443,465,587,993,995,1291,1891,2077,2078,2082,2083,2086,2087,2095,2096,3306,5432,8001,8888,30000:50000"
TCP_OUT = "8140,20,21,22,25,37,43,53,80,110,113,443,465,587,873,1291,1891,2087,2089,2703,3306,5432,8001,8140" 


```

 Um arquivo 'software.txt' é criado com a mesma informação porém sem a formatação markdown.
 
### Softwares Listados

* cPanel
* Sistema Operacional
* CloudLinux
* CageFS
* PHPSelector
* MySQL
* PostgreSQL
* Apache
* Nginx
* PHP
* PHP Handler
* CSF
* Fantástico
* Softaculous
* WHMXtra
* WHMSonic
* RvSkin
* Presence Builder

