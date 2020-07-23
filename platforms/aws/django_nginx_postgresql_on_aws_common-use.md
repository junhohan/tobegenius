# django + nginx + postgresql on AWS Lighsail



### Change default User Name

- 새로운 사용자를 추가하고, 디폴트 사용자의 SSH 퍼블릭키를 새로운 사용자 키로 복사해준다.

```bash
$ sudo adduser [NEW_USER_ID]
[PASSWORD 입력 등]
$ sudo visudo -f /etc/sudoers
...
# User privilege specification
root    ALL=(ALL:ALL) ALL
[NEW_USER_ID]  ALL=(ALL:ALL) ALL   <- 추가
...
$ sudo su - [NEW_USER_ID]
$ mkdir .ssh
$ chmod 700 .ssh
$ touch .ssh/authorized_keys
$ chmod 600 .ssh/authorized_keys
$ vi .ssh/authorized_keys
[1. 다른 터미널 하나를 더 실행시켜서 OLD_USER_ID 로그인]
[2. .ssh/authorized_keys 파일을 열어서 Key 값을 복사]
[3. OLD_USER_ID의 Key 값을 NEW_USER_ID authorized_keys 파일에 복사 후 저장]
$ exit
[중요 : OLD_USER_ID로 접속한 터미널에서 모두 로그아웃한다.]
$ ssh -i [기존_퍼플릭_키.pem] [NEW_USER_ID]@example.com 
```

- 더이상 필요없다면 디폴트 사용자 계정 삭제
  - 삭제하기전에 `NEW_USER_ID`의 권한이 잘 부여되었는지 `sudo`등의 명령어를 사용해본다.

```bash
$ sudo userdel -r [OLD_USER_NAME]
```



##  Change hostname

- hostname 파일을 열고 원하는 이름으로 수정한다.
  `sudo vi /etc/hostname`

- hosts 파일을 열고 새로운 이름이 들어간 내용이 있다면 모두 변경한다.
  `sudo nano /etc/hosts`

- 재부팅을 한다.
  `sudo reboot`



### Change Time Zone

```bash
$ sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
```



### Install Python by Specified Version 3.5.4

```bash
$ sudo apt-get update
$ sudo apt-get install gcc g++ build-essential
$ sudo apt-get install libssl-dev openssl
$ sudo apt-get install zlib1g-dev
$ wget https://www.python.org/ftp/python/3.5.4/Python-3.5.4.tgz
$ tar xzvf Python-3.5.4.tgz
$ cd Python-3.5.4
$ ./configure
$ make
$ sudo make install
```

- 설치 후 `apt-get` 실행 시 dependancy에 문제가 생기면 `--fix-broken` 옵션을 사용한다.

```bash
$ sudo apt --fix-broken install
```



### virtualenv 환경 추가

```bash
$ sudo apt install virtualenv
$ virtualenv shop_env --python=python3.5.4
```



### Activate virtual environment

```bash
$ source ~/environments/shop_env/bin/activate
```



### 부팅할 때 가상환경 활성

- 매번 `source`명령어로 가상환경을 활성하는 것이 귀찮다면, `crontab` 또는 `.bash_profile` (`.profile`)파일을 이용한다.
- `activate_env.sh`파일을 생성하고 아래와 같이 실행할 명령어를 작성한다.

```bash
$ vim activate_env.sh
#!/bin/bash
source ~/environments/shop_env/bin/activate
[SAVE & QUIT]
$ chmod +x activate_env.sh

```



- `.bash_profile`(`.profile`)에 추가한다.

```bash
$ vi .profile
........
# Custom commands START ###############
source ./activate_env.sh
# Custom commands END #################
........
[SAVE & QUIT]
```



- 또는  `crontab`에 추가한다.

```bash
$ crontab -e
@reboot /[PATH]/activate_env.sh
[SAVE & QUIT]
$
```



### nginx 설치

```bash
$ sudo apt install nginx
$ nginx -v
nginx version: nginx/1.14.0 (Ubuntu)
```

- Config File Path : /etc/nginx/nginx.conf
- Service File Path : /etc/systemd/system/nginx.service



### nginx Service Path

```bash
$ sudo systemctl show nginx.service | grep path
$ sudo systemctl status ssh.service
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-03-11 21:56:39 KST; 1 day 10h ago
  Process: 606 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
 Main PID: 627 (sshd)
    Tasks: 1 (limit: 2361)
   CGroup: /system.slice/ssh.service
           └─627 /usr/sbin/sshd -D
```



#### nginx LISTEN Check

```bash
$ sudo netstat -tanpl | grep nginx
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      11245/nginx: master
tcp6       0      0 :::80                   :::*                    LISTEN      11245/nginx: master
```



#### 터미널에서 SSH 연결하기

- pem 파일을 다운로드 한다.
  - Lightsail > 계정 > SSH Key 관리 > 다운로드
  - LightsailDefaultKey-ap-xxxxxxxxx.pem 파일을 원하는 곳에 잘 저장한다.
- pem 파일의 권한을 강화한다.
  - 660 등 사용자에게 권한을 부여하면 "키 파일이 너무 개방되어 있다"는 오류메시지와 함께 사용을 거절당한다.

```bash
$ chmod 600 LightsailDefaultKey-ap-xxxxxxxxx.pem
```

- ssh에 `-i`명령어를 사용해서 인스턴스에 접속한다.
  - `-i`는 Identity File을 의미한다.

```bash
$ ssh -i LightsailDefaultKey-ap-northeast.pem  ubuntu@11.222.333.444
```



### requirements 포멧 문서 작성

```bash
$ vi requirements.txt
beautifulsoup4==4.5.1
bs4==0.0.1
defusedxml==0.5.0
Django==1.10.7
django-admin-sortable2==0.6.10
django-angular==0.8.4
django-appconf==1.0.1
django-classy-tags==0.8.0
django-cms==3.4.2
django-compressor==2.1.1
django-filer==1.2.7
django-filter==1.0.1
django-formtools==1.0
django-fsm==2.4.0
django-fsm-admin==1.2.4
django-haystack==2.6.1
django-ipware==1.1.1
django-mptt==0.8.7
django-parler==1.7
django-polymorphic==1.0.2
django-post-office==3.0.4
django-redis-cache==1.6.0
django-redis-sessions==0.5.0
django-rest-auth==0.5.0
django-sass-processor==0.5.4
django-sekizai==0.10.0
Django-Select2==5.8.10
django-treebeard==4.1.0
djangocms-admin-style==1.2.7
djangocms-bootstrap3==0.2.0
djangocms-cascade==0.13.0
djangocms-text-ckeditor==3.4.0
djangorestframework==3.5.3
djangoshop-stripe==0.2.2
drf-haystack==1.6.1
easy-thumbnails==2.3
elasticsearch==1.7.0
hiredis==0.2.0
html5lib==0.9999999
jsonfield==1.0.3
libsass==0.12.3
oauthlib==1.0.3
Pillow==3.3.0
pluggy==0.3.1
psycopg2==2.7.3
py==1.4.30
Pygments==2.0.2
python-dateutil==2.6.0
python-openid==2.2.5
python3-openid==3.1.0
pytz==2015.7
rcssmin==1.0.6
redis==2.10.3
requests==2.7.0
requests-oauthlib==0.5.0
rjsmin==1.0.12
six==1.10.0
stripe==1.37.0
Unidecode==0.4.18
urllib3==1.12
uWSGI==2.0.15
virtualenv==13.1.2
```



### 패키지 설치

```bash
$ pip install -r requirements.txt
```



- django 설치확인

```bash
$ python -m django --version
```



#### django Setup

- 웹 배포 폴더 : `~/www-data`
- django 프로젝트 : `~/www-data/www_project`
- django APP : `~/www-data/[YOUR-DJANGO-APP]`

```bash
$ django-admin startproject www_project
$ mv www_project www-data
$ sudo chown www-data:www-data www-data
$ cd www-data/
$ python manage.py startapp [YOUR-DJANGO-APP]
```



```
www-data/
├──[YOUR-DJANGO-APP]
│   ├── __init__.py
│   ├── __pycache__
│   │   └── __init__.cpython-35.pyc
│   ├── admin.py
│   ├── apps.py
│   ├── migrations
│   │   └── __init__.py
│   ├── models.py
│   ├── tests.py
│   └── views.py
├── manage.py
└── www_project
    ├── __init__.py
    ├── __pycache__
    │   ├── __init__.cpython-35.pyc
    │   ├── settings.cpython-35.pyc
    │   ├── urls.cpython-35.pyc
    │   └── wsgi.cpython-35.pyc
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```





#### uWSGI 연동

- `ALLOWED_HOSTS`에 AWS에서 설정한 Static IP주소를 추가한다.
- SQL은 사용하지 않으므로 해당 내용을 주석처리한다.

```bash
$ vi www-data/www_project/settings.py
...
ALLOWED_HOSTS = ['11.222.333.444']
...
DATABASES = {
    'default': {
#        'ENGINE': 'django.db.backends.sqlite3',
#        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
...
```

- 이제 uWSGI를 사용해서 서버를 구동해본다.

```bash
$ cd www-data
$ uwsgi --http :8000 --module www_project.wsgi
*** Starting uWSGI 2.0.15 (64bit) on [Tue Mar  3 16:56:05 2020] ***
compiled with version: 7.4.0 on 02 March 2020 15:42:28
os: Linux-4.15.0-1021-aws #21-Ubuntu SMP Tue Aug 28 10:23:07 UTC 2018
nodename: [YOUR-NODENAME]
machine: x86_64
clock source: unix
detected number of CPU cores: 1
current working directory: /home/[YOUR-USER-NAME]/www-data
detected binary path: /home/[YOUR-USER-NAME]environments/shop_env/bin/uwsgi
!!! no internal routing support, rebuild with pcre support !!!
*** WARNING: you are running uWSGI without its master process manager ***
your processes number limit is 7873
your memory page size is 4096 bytes
detected max file descriptor number: 1024
lock engine: pthread robust mutexes
thunder lock: disabled (you can enable it with --thunder-lock)
uWSGI http bound on :8000 fd 4
spawned uWSGI http 1 (pid: 23273)
uwsgi socket 0 bound to TCP address 127.0.0.1:33627 (port auto-assigned) fd 3
Python version: 3.5.4 (default, Mar  1 2020, 17:02:18)  [GCC 7.4.0]
*** Python threads support is disabled. You can enable it with --enable-threads ***
Python main interpreter initialized at 0x5654b6e8d650
your server socket listen backlog is limited to 100 connections
your mercy for graceful operations on workers is 60 seconds
mapped 72768 bytes (71 KB) for 1 cores
*** Operational MODE: single process ***
WSGI app 0 (mountpoint='') ready in 0 seconds on interpreter 0x5654b6e8d650 pid: 23272 (default app)
*** uWSGI is running in multiple interpreter mode ***
spawned uWSGI worker 1 (and the only) (pid: 23272, cores: 1)
```



#### File download

- 디렉토리를 다운로드 받으려면 `-r`옵션을 추가한다.

```bash
$ scp [YOUR_USER_ID]@[HOST]:foobar.txt .
```



#### Root Password 설정

```bash
$ sudo passwd root
Enter new UNIX password: [YOUR-PASSWORD]
Retype new UNIX password:
passwd: password updated successfully
```



#### SSH Cert : LetsEncrypt

- 참고 : [How to Setup Let’s Encrypt SSL](https://tecadmin.net/install-lets-encrypt-create-ssl-ubuntu/)

```bash
$ sudo wget https://dl.eff.org/certbot-auto -O /usr/local/bin/certbot-auto
$ sudo chmod a+x /usr/local/bin/certbot-auto
$ sudo /usr/local/bin/certonly --standalone -d [YOUR-URL].com  -d www.[YOUR-URL].com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Enter email address (used for urgent renewal and security notices) (Enter 'c' to
cancel): [YOUR-ID]@gmail.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: N
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for [YOUR-URL].com
http-01 challenge for www.[YOUR-URL].com
Cleaning up challenges
Problem binding to port 80: Could not bind to IPv4 or IPv6.

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
```





#### 서비스 구동

- Service File Path : /etc/systemd/system/

```
$ sudo systemctl start [SERVICE_NAME]
```



### Install npm

```bash
$ sudo apt install npm
$ cd ~/[YOUR-DJANGO-APP]/example
$ npm install
```







## uWSGI 

#### Settings

- File Path : ~/[YOUR-DJANGO-APP]/example/docker-files

```bash
$ ls -al  ~/[YOUR-DJANGO-APP]/example/docker-files
total 32
drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 27 19:20 .
drwxrwxr-x 5 ubuntu ubuntu 4096 Feb 27 18:57 ..
-rw-rw-r-- 1 ubuntu ubuntu 3079 Feb 26 13:31 README.md
-rw-rw-r-- 1 ubuntu ubuntu  553 Feb 26 13:31 [YOUR-DJANGO-APP].ini
-rw-rw-r-- 1 ubuntu ubuntu  932 Feb 26 13:31 wsgi.py
```

- [YOUR-DJANGO-APP].ini

```bash
[uwsgi]
#plugins = python3, logfile
chdir = /home/ubuntu/[YOUR-DJANGO-APP]/example/
umask = 002
socket = /home/ubuntu/[YOUR-DJANGO-APP]/example/[YOUR-DJANGO-APP].sock
# socket = 11.222.333.444 IP를 사용할 경우 IP를 지정한다.
chmod-socket = 666
env = DJANGO_WORKDIR=/home/ubuntu/[YOUR-DJANGO-APP]/workdir
env = DJANGO_SETTINGS_MODULE=[YOUR-DJANGO-APP].settings
module = wsgi:application
buffer-size = 32768
static-map = /static=/home/ubuntu/[YOUR-DJANGO-APP]/workdir/static
static-map = /media=/home/ubuntu/[YOUR-DJANGO-APP]/workdir/media
post-buffering = 1
processes = 1
threads = 1
logger = file:/web/logs/shop.log
home = /home/[YOUR-USER-ID]/environments/shop_env
```



#### uWSGI 실행

```bash
$ uwsgi --ini ~/[YOUR-DJANGO-APP]/example/docker-files/[YOUR-DJANGO-APP].ini
```

- 경고메시지가 보임
  - `!!! no internal routing support, rebuild with pcre support !!!` 
- 아래 커멘드를 실행해서 `uwsgi` 다시 설치 후 사라짐

```bash
$ pip uninstall uwsgi
$ sudo apt-get install libpcre3 libpcre3-dev
$ pip install uwsgi
```



- socket을 이용한 통신

```bash
upstream www_project {
	#server 127.0.0.1:35365; <- 주석처리
	server unix:/home/[YOUR-DJANGO-APP]/www-data/www_project/[YOUR-DJANGO-APP].sock;
}
```

```bash
$ sudo ../environments/shop_env/bin/uwsgi --socket ./www_project/[YOUR-DJANGO-APP].sock --uid www-data --gid www-data --module www_prect.wsgi --chmod-socket=666
```

- Socket 파일에 대한 퍼미션 오류가 발생했을 때

  - 모든 폴더를 `$ chown -R [USER-NAME]:[USER-NAME] MY_PROJECT_DIR` 명령어로 사용자/그룹을 통일 시켜준다.
  - 문제가 되었던 `MY_PROJECT.sock`파일은 삭제하고 `--uid [USER-NAME] --gid [USER-NAME]` 옵션을 부여해서 `uwsgi`를 다시 실행한다.

  

## postqresql 

#### 9.6 설치

```bash
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main"
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# 에러가 발생해도 문제없이 설치됨 XD #
$ sudo apt-get update
$ sudo apt-get install postgresql-9.6
```



#### 초기 비밀번호 설정

- `alter user`쿼리를 이용해서 비밀번호 변경

```bash
$ sudo su - postgres
$ psql
postgres@[YOUR-USER-ID]:~/9.6/main$ psql
psql (9.6.17)
Type "help" for help.
postgres=# alter user postgres with password '[YOUR-PASSWORD]';
ALTER ROLE
```



#### 실행방법

```bash
$ sudo systemctl stop postgresql
$ sudo systemctl start postgresql
$ sudo systemctl restart postgresql
```



#### DB Path 보기

```bash
$ psql
psql (9.6.17)
Type "help" for help.

postgres=# SHOW data_directory;
        data_directory
------------------------------
 /var/lib/postgresql/9.6/main
(1 row)
```



#### Log 파일 삭제

- pg_log 파일이 22GB 이므로 삭제함
- 삭제해도 되는 파일이라고 함
- 보통 `crontab`을 이용해서 주기적으로 삭제한다고 한다.
- [주의] 아직 적용안함 로그 쌓이는 것을 보고 추후에 적용할 예정

```
$ crontab -e
30 05 * * 6 ~/remove_logs.sh
```



```
postgres@[YOUR-USER-ID]:~/pg_log/*
```



#### psycopg2

- `psycopg2`를 삭제하고 `psycopg2-psycopg2-binary`를 설치한다.

```bash
$ pip uninstall psycopg2
$ pip install psycopg2-binary
```



#### djando-shop 설치

- Version

```bash
$ pip list
...
django-shop (0.10.2, /home/[YOUR-USER-ID]/[YOUR-DJANGO-APP])
...
```



#### 액세스 폴더 소유자 변경

- 검색하다 알게되었는데 액세스되는 데이터 디렉토리의 소유자를 `www-data`로 표기하는게 좋다고 한다.
  - 한번에 어느 폴더인지 알 수 있음
  - root 권한의 소유자 디렉토리가 `nginx`에서 접근을 못하는 경우도 있다고 함

- [주의] 실제 적용하지는 않음

```bash
$ sudo chown -R [USER-NAME]:[USER-NAME] [YOUR-DJANGO-APP]
```



#### 크롬에서만 IP로 접속(80 port)이 안되는 문제

- 크롬에서만 80포트, IP주소로 접속을 했을 때, TIME_OUT 에러가 발생
- `chrome://flags`로 접속해서 `Reset all to default`를 실행한 후, 크롬을 재시작한 후 현상 사라짐
- 참고 : [How to Fix DNS_PROBE_FINISHED_NXDOMAIN in Chrome](https://kinsta.com/knowledgebase/dns_probe_finished_nxdomain/#reset-chrome-flags)

* 참고1 : [Troubleshoot Nginx: 10 typical errors](https://blog.serverdensity.com/troubleshoot-nginx/)
* 참고2 : [django와 WSGI와 NGINX](https://crystalcube.co.kr/205)



## System Operation

#### crontab

- 매주 토요일 오전 5시 30분에 postgresql 로그 `pg_log` 폴더 삭제

```bash
$ sudo su - postgres
$ crontab -e
30 5 * * 6 ~/remove_logs.sh 
```

- 시스템 리부팅할 때 `postgresql`은 자동 실행되는 것을 확인
  - `run_postgresql.sh` 파일을 만들어놓고 `crontab`에 추가하지는 않음



#### nginx

- 시스템 리부팅 시 service 자동실행 확인

```bash
$ sudo service --status-all
...
[ + ]  nginx
...
```



#### uwsgi systemd

- `/lib/systemd/system` 위치에 `uwsgi.service` 파일 작성
- 참고 : [uwsgi Systemd](https://uwsgi-docs.readthedocs.io/en/latest/Systemd.html)

```bash
$ sudo vi /lib/systemd/system/uwsgi.service
[Unit]
Description=uWSGI Emperor
After=syslog.target

[Service]
ExecStart=/home/[YOUR-USER-ID]/environments/shop_env/bin/uwsgi --ini /home/[YOUR-USER-ID]/www-data/www_project/[YOUR-DJANGO-APP]_uwsgi.ini
# Requires systemd version 211 or newer
RuntimeDirectory=uwsgi
Restart=always
KillSignal=SIGQUIT
Type=notify
StandardError=syslog
NotifyAccess=all

[Install]
WantedBy=multi-user.target
```



- Enable uwsgi.service

```bash
$ sudo systemctl enable uwsgi.service
Created symlink /etc/systemd/system/multi-user.target.wants/uwsgi.service → /lib/systemd/system/uwsgi.service.
$ sudo reboot
[이후로는 재부팅 후 자동실행됨]
```



- systemd 서비스 시작 & 종료

```bash
$ sudo systemctl start uwsgi.service
$ sudo systemctl stop uwsgi.service
$ sudo systemctl restart uwsgi.service
```



#### Let's Encrypt SSL

- Let's Encrypt를 사용하여 인증서 등록 및 생성

```bash
$ sudo wget https://dl.eff.org/certbot-auto -O /usr/sbin/certbot-auto
$ sudo chmod a+x /usr/sbin/certbot-auto
$ sudo certbot-auto certonly --standalone -d [mysite.com]  -d [www.mysite.com]
```

- `nginx.conf`에 적용
  - 적용한 후 `sudo systemctl restart nginx`를 실행

```bash
server {
  listen       443;
  ...
  ssl on;
  ssl_certificate         /etc/letsencrypt/live/[mysite.com]/fullchain.pem;
  ssl_certificate_key     /etc/letsencrypt/live/[mysite.com]/privkey.pem;
  ...
}
```



- 인증서 갱신 모의 테스트
  - 인증서 갱신이 성공하는지 테스트해보려면 아래 스크립트를 실행한다.
  - 인증 과정은 그대로 진행하지만, 실제 인증서 관련 파일들은 변경하지 않는다.

```bash
$ sudo certbot renew --dry-run
```



- 80 포트를 사용(bind)할 수 없어 모의 테스트를 실패한 예시

```bash
Saving debug log to /var/log/letsencrypt/letsencrypt.log
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/[YOUR-URL].com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Attempting to parse the version 1.3.0 renewal configuration file found at /etc/letsencrypt/renewal/[YOUR-URL].com.conf with version 0.31.0 of Certbot. This might not work.
Cert not due for renewal, but simulating renewal for dry run
Plugins selected: Authenticator standalone, Installer None
Renewing an existing certificate
Performing the following challenges:
http-01 challenge for [YOUR-URL].com
http-01 challenge for www.[YOUR-URL].com
Cleaning up challenges
Attempting to renew cert ([YOUR-URL].com) from /etc/letsencrypt/renewal/[YOUR-URL].com.conf produced an unexpected error: Problem binding to port 80: Could not bind to IPv4 or IPv6.. Skipping.
All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/[YOUR-URL].com/fullchain.pem (failure)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates below have not been saved.)

All renewal attempts failed. The following certs could not be renewed:
  /etc/letsencrypt/live/[YOUR-URL].com/fullchain.pem (failure)
** DRY RUN: simulating 'certbot renew' close to cert expiry
**          (The test certificates above have not been saved.)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1 renew failure(s), 0 parse failure(s)

IMPORTANT NOTES:
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
```



- 인증서 갱신은 `root`가 담당한다.

```bash
$ sudo su - 
$ vi letsencrypt_renew.sh
#!/bin/bash
certbot renew --noninteractive --pre-hook "systemctl stop nginx" --post-hook "systemctl restart nginx"
```



- Crontab 설정
  - 매일 오전 3, 5시 두 번에 걸쳐서 인증서 갱신을 한다.
  - 갱신이 잘 되었는지 renew.log를 종종 확인하자.

> 인증서 갱신이 실패할 경우와 let's encrypt 측의 오류로 인해 자주 갱신을 하라는 말들이 많다. 심지어 2시간에 한 번씩 해야한다는 말까지 있는데 다소 옛날 이야기인 것 같아서 하루에 2번 정도 시도하면 충분할 것 같다.

```bash
$ sudo su -
$ crontab -e
0 * * * * /home/[YOUR-USER-ID]/update_statistic.sh
01 03,05 * * * /root/letsencrypt_renew.sh > renew.log
```



- 인증서 갱신 로그 예시 : `root/renew.log`
  - 아직 갱신할 시기가 아니라고 skip했다는 메시지

```bash
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/[YOUR-URL].com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

The following certs are not due for renewal yet:
  /etc/letsencrypt/live/[YOUR-URL].com/fullchain.pem expires on 2020-06-08 (skipped)
No renewals were attempted.
No hooks were run.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```



#### nginx redirect 80 to 443

- 인증서를 발급받았다면 이제 80포트를 443포트로 리다이렉션 시킨다.
- `/etc/nginx/nginx.conf`

```bash
server {
  listen 80;
  server_name [YOUR-URL].com www.[YOUR-URL].com;
	return 301 https://$host$request_uri;
}
```



