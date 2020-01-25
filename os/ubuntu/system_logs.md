# System Logs

### 시스템 로그 설정
`/etc/rsyslog.conf`은 시스템로그에 대한 메인 설정 파일이다. 이 파일을 변경하면 각각의 로그파일의 위치, 이름 변경, 원격시스템의 로그 수신, 원격시스템으로 로그 송신, 시간표기 형식 등 다양한 설정이 가능하다. `/etc/rsyslog.d/` 폴더 안에 *.conf 파일들은 메인 설정 파일에서 가져가서 함께 반영한다.

```
$ vim /etc/rsyslog.conf
```

설정을 변경 후, rsyslog 적용하기

```
$ sudo restart rsyslog
```

### 시스템 로그의 종류
[참고페이지 : www.thegeekstuff.com](http://www.thegeekstuff.com/2011/08/linux-var-log-files/)

1. /var/log/messages  
  전체 시스템 메시지. 시스템이 시작되는 동안의 메시지. mail, cron, daemon, kern, auth 등과 관련된 메시지를 포함한다.
  
2. /var/log/dmesg  
  커널 링 버퍼 정보를 포함. 시스템이 부팅될 때, 커널이 감지한 `하드웨어 정보`를 화면에 출력하는 메시지가 적힌 로그파일. `$ dmesg` 명령어로도 확인 가능
  
3. /var/log/auth.log  
   시스템 인증 정보. 사용자 로그인 정보와 인증과 관련된 행위(sudo 명령 사용 내역 등)에 대한 로그. 
   비정상적인 사용자의 로그인 시도에 대한 내용도 확인할 수 있다.

   베트남IP로 접근을 시도한 로그
   
  ```
  Apr  9 00:14:40 my-server sshd[20005]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=103.207.39.214
  ```
  
  sudo 명령어 사용 로그
  
  ```
  Apr  9 00:54:16 my-server sudo: my_user_id : TTY=pts/14 ; PWD=/home/my_user_id ; USER=root ; COMMAND=/usr/bin/tail -n 100 -f /var/log/auth.log
  ```
  
4. /var/log/boot.log
  시스템이 부팅될 때 실행되는 서비스 데몬들의 상태가 적힌 로그
  
  ```
   * Starting OpenSSH server  
   [ OK ]  
   * Starting MongoDB  
   [fail]  
   * Stopping save kernel messages    
   [ OK ]    
  ```
  
5. /var/log/dpkg.log  
  `dpkg` 명령어로 패키지를 설치하거나 제거할 때 기록하는 로그
  
6. /var/log/kern.log  
  커널에서 기록하는 로그. 시스템에 문제가 발생했을 때 도움이 된다.
  
7. /var/log/lastlog  
  모든 유저에 대한 최근 로그인 정보를 볼 수 있다. ascii 파일이 아니기 때문에 내용을 확인하려면 `$ lastlog` 명령어를 사용해야 한다.
  
8. /var/log/alternatives.log  
  `update-alternatives` 명령어에 대한 로그. 우분투에서는 `update-alternatives` 명령어로 실행파일의 심볼릭 링크를 관리할 수 있는데, 예를들면 python의 버전이 여러개 설치되어 있을 때, `$ python`을 실행할 때 어떤 버전과 연결지을지 설정할 수 있다.
  
9. /var/log/btmp  
  실패한 로그인 시도에 대한 로그. 내용을 확인하려면 `$ last`명령어를 사용해야 한다.
  
  ```
  $ sudo last -f /var/log/btmp
  ```
  
  내용을 보면, 간단한 ID로 접근을 시도하는 내용을 확인할 수 있다. (테스트 서버라고 해도 간단한 ID, PW는 사용하면 안될 것 같다. 특히 `admin, root, user`는 저들에게 가장 인기가 높아보인다.
  
  ```
  1234     ssh:notty    193.201.224.215  Sat Apr  1 09:48 - 09:48  (00:00)
  1234     ssh:notty    193.201.224.215  Sat Apr  1 09:48 - 09:48  (00:00)
  1111     ssh:notty    193.201.224.215  Sat Apr  1 09:47 - 09:48  (00:00)
  1111     ssh:notty    193.201.224.215  Sat Apr  1 09:47 - 09:47  (00:00)
  ```
  
10. /var/log/cups
   프린터, 출력관련 로그파일이 담긴 폴더.
   
11. /var/log/anaconda.log  
  리눅스를 설치할 때 발생하는 모든 설치 정보에 대한 로그
  Ubuntu 4.4.0을 설치했는데 이 파일이 없다. 왜지?
  
12. /var/log/yum.log  
  `$ yum`을 사용해서 패키지를 설치한 내용을 기록하는 로그 파일.
  
13. /var/log/cron  
  cron 데몬이 cron job을 실행할 때마다 기록하는 로그. 그런데, 이 파일이 없다. cron에 대한 기본 로그파일은 `/var/log/syslog`라고 한다.  
  내용이 적지 않아서 `grep` 명령어를 사용해서 조회한다.
  
  ```
  $ sudo grep CRON /var/log/syslog
  ```
  
  이 작업이 번거로우면 cron에 대한 로그파일을 따로 만들도록 설정하면 된다.
  
  ```
  $ sudo vim /etc/rsyslog.d/50-default.conf
  #cron.* /var/log/cron.log    <- remove sharp(#), save and quit
  $ sudo service rsyslog restart
  ```
  위와 같이 하면, 이제 `/var/log/cron.log` 파일이 생성된다. (바로는 안되고 다음 번 cron job이 실행될 때 만들어진다.)  
  [참고페이지 : askubuntu.com](http://askubuntu.com/a/121560/430568)

14. /var/log/wtmp or /var/log/utmp
  로그인 기록. `$ who` 명령어는 `wtmp` 또는 `utmp` 파일을 화면에 출력해준다. 시스템에 누가 로그인했는지 조회할 수 있다. 

25. /var/log/faillog  
  로그인 실패한 사용자에 대한 로그. `$ faillog` 명령어로 이 파일을 조회할 수 있다.  
  Ubuntu 4.4.0에서는 이 파일이 없다. 왜지?
  

