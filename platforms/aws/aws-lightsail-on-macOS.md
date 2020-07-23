# AWS Lightsail on macOS



#### Aim

Ubuntu + WordPress



#### Instance

> Lightsail 인스턴스는 **VIrtual Machine** or **Virtual Private Machine**
> 인스턴스를 생성할 때 클릭만으로 기본 OS, 애플리케이션(워드프레스 등) 또는 개발 스택을 가진 인스턴스 이미지를 한 방에 추가할 수 있다.



#### Create Instance

인스턴스 생성 버튼을 누르면 OS 와 함께 설치할 어플리케이션 목록이 나온다.

```
플랫폼 선택 : Linux/Unix
블루프린트 선택 : WordPress 5.2.2-3 (2019.11.24 현재)
```



- 설치되는 WP 이미지는?
  - Bitnami(애플리케이션 패키징 리더 회사) 및 Automattic(현 WordPress 개발사)에서 인증하는 이미지
  - Amazon Lightsail에서 WordPress 실행을 위해 바로 실행할 수 있도록 미리 구성된 이미지
  - Jetpack, Akismet, All in One SEO Pack, WP Mail, Google Analytics for WordPress 및 Amazon Polly 플러그인은 모두 이 이미지에 사전 설치되어 있음
  - Let's Encrypt SSL 인증서는 자동 구성 스크립트를 통해 지원



#### Lightsail 리소스의 이름

```
[MY-SERVICE-NAME]
```



#### 키 전용 태크 입력

```
KEY : [MY-SERVICE-NAME]
```



#### 키-값 태그 입력

```
KEY : [MY-SERVICE-NAME] 
VALUE : [MY-VALUE]
```



#### 생성 완료

- 생성 완료 후 5분 정도 후에 접속이 가능



#### 설치된 버전 (2019.11.24 현재)

- Ubuntu 16.04.6 LTS

	```
	$ cat /etc/issue
	Ubuntu 16.04.6 LTS \n \l
	```
	
- PHP 7.3.7

  ```
  $ php --version
  PHP 7.3.7 (cli) (built: Jul 22 2019 11:51:18) ( NTS )
  Copyright (c) 1997-2018 The PHP Group
  Zend Engine v3.3.7, Copyright (c) 1998-2018 Zend Technologies
      with Zend OPcache v7.3.7, Copyright (c) 1999-2018, by Zend Technologies
  ```

- WordPress 5.2.2

  - 페이지 HTML 소스 확인

  ```
  <meta name="generator" content="WordPress 5.2.2"/>
  ```

- MySQL 8.0.17

  ```
  $ mysql --version
  /opt/bitnami/mysql/bin/mysql.bin  Ver 8.0.17 for linux-glibc2.12 on x86_64 (MySQL Communit
  y Server - GPL)
  ```

  



#### 네트워크 탭에서 고정IP 생성

```
고정IP 리소스 이름 : WP_MY_NAME_IP
연결할 인스턴스 ID를 선택 : WP_MY_NAME
```



인터넷 브라우저에서 생성된 IP로 접속하면 Default Wordpress 페이지가 뜬다.



#### Bitnami Default Password

```
$ ls -al
...
lrwxrwxrwx 1 bitnami bitnami   17 Jul 25 15:34 apps -> /opt/bitnami/apps
-rw------- 1 bitnami bitnami   13 Nov 24 13:33 bitnami_application_password
-r-------- 1 bitnami bitnami  424 Nov 24 13:33 bitnami_credentials
...
```



```
$ cat bitnami_credentials 
Welcome to the Bitnami WordPress Stack

******************************************************************************
The default username and password is 'user' and 'XXXXXXXXXXXXXX'.
******************************************************************************

You can also use this password to access the databases and any other component the stack i
ncludes.

Please refer to https://docs.bitnami.com/ for more details.
```



#### Change Default User ID and Password



- 보안을 위해 초기에 생성된 'user'와 초기 password 를 변경한다.
- 크롬 등으로 나의 WP 웹페이지에 접속한다.
- Login을 눌러 ID : user PW : XXXXXXXXXX 를 입력하여 로그인한다.
- 좌측 메뉴에서 [User]를 클릭
- [Add User]를 선택해서 ID, E-mail, Administrator 선택 등을 통해 새로운 관리자 계정을 생성한다.
- User 계정의 패스워드로 변경한다.



#### NGINX Configuration

- NGINX 설정파일 수정



```BASH
server {
		listen       80;
		server_name  my.url.com;
		index index.html;
		root /home/[USER-NAME]/[MY-SERVICE-NAME];
		location ^~ /.well-known/acme-challenge/ {
		index index.html;
		root /home/[USER-NAME]/[MY-SERVICE-NAME]/;
	}
	return 301 https://$host$request_uri;
}
```



#### ROOT PATH

```bash
$ mkdir -p /home/[USER-NAME]/[MY-SERVICE-NAME]/wordpress
$ sudo wget -c "https://wordpress.org/latest.tar.gz" -O - | sudo tar -xz --strip 1 -C ./wordpress/
```

- ROOT : /home/[USER-NAME]/[MY-SERVICE-NAME]
- WordPress : /home/[USER-NAME]/[MY-SERVICE-NAME]/wordpress



#### Create Config File for WP

```
$ cp wp-config-sample.php wp-config.php
```



#### Install mysql

```
$ sudo apt-get update
$ sudo apt-get install mysql-server mysql-client
```



#### mysql Initial Setup

```
$ mysql -u root -p
mysql> CREATE DATABASE [MY-SERVICE-NAME] CHARACTER SET UTF8 COLLATE UTF8_BIN;
mysql> CREATE USER '[MY-SERVICE-NAME]'@'%' IDENTIFIED BY '[MY-PASSWORD]';
mysql> GRANT ALL PRIVILEGES ON [MY-SERVICE-NAME].* TO '[USER-NAME]'@'%';
mysql> FLUSH PRIVILEGES;
mysql> quit;
Bye
```



#### Install php7.0

```
$ sudo apt-get install -y language-pack-en-base
$ sudo add-apt-repository ppa:ondrej/php
$ sudo apt-get update
$ apt-cache search php7
```







#### 패키지 정보 업데이트

```
$ sudo apt update
```



#### How to upgrade a instance

- 참고 : [Lightsail 상품은 어떻게 변경합니까?](https://aws.amazon.com/ko/premiumsupport/knowledge-center/change-lightsail-plan/)

- 인스턴스의 리소스가 부족해서 업그레이드를 하고 싶은 경우, 스냅샷을 이용한다.
  - [스냅샷을 생성한 후 스냅샷에서 더 큰 인스턴스를 생성한다.](https://lightsail.aws.amazon.com/ls/docs/en/articles/how-to-create-larger-instance-from-snapshot-using-console).

- downgrade
  - 인스턴스에 저장된 정보를 [다른 AWS 서비스](https://lightsail.aws.amazon.com/ls/docs/en/articles/using-lightsail-with-other-aws-services)에 백업한다.
  - 더 작은 Lightsail 인스턴스를 시작한다.
  - 기존 인스턴스에서 새 인스턴스로 정보를 마이그레이션한다.



#### SSH Clinet 프로그램으로 연결하기

- pem 파일을 다운로드 한다.
  - Lightsail > 계정 > SSH Key 관리 > 다운로드
  - LightsailDefaultKey-ap-xxxxxxxxx.pem 파일을 원하는 곳에 잘 저장한다.
- pem 파일의 권한을 강화한다.
  - 660 등 사용자에게 권한을 부여하면 "키 파일이 너무 개방되어 있다"는 오류메시지와 함께 사용을 거절당한다.

```
$ chmod 600 LightsailDefaultKey-ap-xxxxxxxxx.pem
```

- ssh에 `-i`명령어를 사용해서 인스턴스에 접속한다.
  - `-i`는 Identity File을 의미한다.

```bash
$ ssh -i [PATH_TO_PEM]/LightsailDefaultKey-ap-xxxxxxxxx.pem [YOUR_ID]@[YOUR_IP_ADDRESS]
```



- 원격 호스트가 변경되어 접속할 수 없다는 메시지가 보이는 경우

```bash
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:xUb0HOqxxxxxxxxxxxxxxxxxxxxxxxxxx8VdILnAUMI.
Please contact your system administrator.
Add correct host key in /Users/user_name/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /Users/user_name/.ssh/known_hosts:4
ECDSA host key for xx.xxx.xxx.xx has changed and you have requested strict checking.
Host key verification failed.
```

`known_hosts`파일에서 기존의 key를 삭제한 후, 다시 시도한다.

```bash
$ vi /Users/[USER-NAME]/.ssh/known_hosts
```

