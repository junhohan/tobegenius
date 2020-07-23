# Shell Commands
## crontab (on Ubuntu, Rasbian)
crontab 편집하기  

```BASH
$ sudo crontab -e
```

재부팅 후 특정 스크립트를 딱 한 번 실행하기 

```BASH
# Add codes below, save and exit
@reboot my_script
```

재부팅 후 지정한 시간 이후에 스크립트를 실행하기

```BASH
@reboot sleep 60 && my_script
```

[주의]   
* 간혹 스크립트에 확장자가 있으면 재부팅해도 실행이 안되는 경우가 있으니, "*.sh"등의 확장자는 지운다.  
* 실행할 스크립트는 실행이 가능한지 확인한다. `$ chmod 755 my_script`

한 시간, 하루, 한 주, 한 달에 한 번 주기적으로 실행
아래 폴더에 실행할 파일을 넣으면 된다.
파일의 실행권한을 부여하는 것을 잊으면 안된다. `$ chmod 755 [FILENAME]`

```
/etc/cron.hourly/
/etc/cron.daily/   
/etc/cron.monthly/ 
/etc/cron.weekly/
```



#### crontab 실행 로그 보기

```bash
$ tail /var/log/syslog <- 시스템로그
$ grep CRON /var/log/syslog <- cron에 대한 시스템로그만 보기
```





## 시간 동기화 (on Ubuntu)

```
$ date && sudo ntpdate ntp.ubuntu.com && date
```
```
2017. 04. 09. (일) 00:26:51 KST
 9 Apr 00:27:16 ntpdate[20800]: step time server 91.189.91.157 offset 16.050083 sec
2017. 04. 09. (일) 00:27:16 KST
```

[참고페이지](http://system-monitoring.readthedocs.io/en/latest/log.html)



## Service (on Ubuntu)

#### Service 조회하기

```Bash
  $ sudo service --status-all
  [ + ]  friendly-recovery
  [ - ]  grub-common
  [ ? ]  irqbalance
  [ + ]  kerneloops
  [ ? ]  killprocs
  [ ? ]  kmod
  [ ? ]  lightdm
  [ + ]  mongodb
  [ - ]  mosquitto
```

```Bash
  $ sudo service mongodb status
  mongodb start/₩running, process 17146
```

목록 표기 설명  

* [ + ] : Running
* [ - ] : Stopped
* [ ? ] : Managed by `Upstart` or Cannot be determined for some reason.


## Upstart (on Ubuntu)

> ***Upstart란?***  
> 우분투에서 제공하는 특별한 서비스 관리 툴  
> 부팅할 때 항상 실행해야 하고, 오류로 종료되어도 자동으로 다시 시작해야 하며 다른 서비스와의Dependancy를 설정해야 할 때는 `Upstart`로 구동하는 것이 좋다.  
> Ubuntu 14.04에는 Systemd를 실행할 수 없어서 Upstart를 사용해야 한다.  
> Ubuntu 15.04부터 새로운 Init 시스템인 Systemd가 디폴트가 되었다.   
> [Systemd For Upstart User](https://wiki.ubuntu.com/SystemdForUpstartUsers)  
> [Understanding Systemd](http://blu.org/meetings/2016/03/BLU-20160315-systemd.pdf)    
> 자세한 설명 및 설정 방법 : [Link](http://blog.sapzil.org/2014/08/12/upstart/)  

#### Config 파일 작성하기

```Bash
  description "MY APP"
  start on net-device-up
  start on started OTHER_APP and ANOTHER_APP
  start on runlevel [2345]
  stop on runlevel [06]
  respawn
  respawn limit 10 5
  chdir /home/my/app/
  exec /home/my/app/my_app > /var/log/my_app/my_app.log 2>&1
```

* `start on net-device-up` : 네트워크가 연결된 후 실행하도록 설정
* `start on started OTHER_APP` : 다른 실행파일을 실행한 후에 my_app을 실행하도록 설정. 뒤에 `and ANOTHER_APP`을 붙여서 의존성을 추가로 부여할 수 있음
* `run level` : 부팅될 때 실행하고, 종료될 때 죽어라. [참고 - upstart.ubuntu.com](http://upstart.ubuntu.com/cookbook/#runlevels)
* `respawn` : 프로세스가 죽으면 재시작
* `respawn limit 10 5` : 재시작하는 회수 제한. 10번 재실행을 하고 각각의 재시도 간격은 5초다. 만약 재시작의 제한을 두지 않으려면 `respawn limit unlimited`으로 설정한다. `respawn`과 별도로 작성해야 한다. 
* `exec` : 파일을 실행. `exec PATH_TO_RUN_MY_APP > PATH_TO_LOG_FILE 2>&1` 형식으로 적으면 된다.

#### 설정 Reload

```Bash
  $ sudo initctl reload-configuration
```

#### Start, Stop, Restart

```Bash
  $ sudo start my_app
  my_app start/running, process 4270
```

```Bash
  $ sudo stop my_app
  my_app stop/waiting
```

```Bash
  $ sudo restart my_app
  my_app start/running, process 11106
```

[참고] restart 또는 stop을 실행할 때, "Unknown instance:" 라는 메시지가 출력되면 ***"앱이 실행되고 있지 않아서 stop할게 없어요!"*** 라는 의미다. start가 되지 않을 때는 `/var/init/my_app.conf` 파일에 문제가 있거나, 파일을 실행할 때 오류가 발생하거나 둘 중 하나다.



#### Upstart 서비스 상태 조회

```Bash
  $ sudo initctl list
  avahi-daemon start/running, process 704
  gitlab-runsvdir start/running, process 1089
  mountnfs-bootclean.sh start/running
  tty4 start/running, process 1091
  whoopsie start/running, process 1316
  ...
```



#### 사용중인 service 파일 위치

```bash
$ systemctl show ssh.service | grep Path
```



## sed 명령어

#### 모든 파일의 모든 문자열 Replace (on macOS)

sed options  

* [--exclude-from] : 내 스크립트 파일은 제외하고 검색(grep)
* ['s/OLD/NEW/g'] : 's'는 substitute(대리, 대체자), 'g'는 global을 의미한다. 풀어서 설명하면 "파일 내 모든(g) "OLD"를 "NEW"로 변경(s)해라"다. 
* [-i ""] : "원본파일(in-place)에서 변경한 후 저장해라"는 의미이고, "" 안에는 필터링할 확장자(e.g cc, cpp etc.)를 표기할 수 있다. ""로 빈 칸(zero-length)을 넣으면 백업파일도 만들지 않고 변경해버린다. 사용하기 전 반드시 주의가 필요하다.

> 만약, 정규식을 ['s/OLD/NEW/]와 같이 g를 제거하면, 문장에서 첫 번째로 매칭되는 단어만 변경한다. 

[myshell.sh]

```Bash
  #!/bin/bash
  grep -rl --exclude-from=myshell.sh "OLD" | xargs sed -i "" -e 's/OLD/NEW/g'
```



## wget

















## Ubuntu change hostname command

- hostname 파일을 열고 원하는 이름으로 수정한다.
  `sudo vi /etc/hostname`

- hosts 파일을 열고 새로운 이름이 들어간 내용이 있다면 모두 변경한다.
  `sudo nano /etc/hosts`

- 재부팅을 한다.
  `sudo reboot`











## Install Python by Specified Version



```bash
$ sudo apt-get install libssl-dev openssl
$ sudo apt-get install zlib1g-dev
$ wget https://www.python.org/ftp/python/3.5.4/Python-3.5.4.tgz
$ tar xzvf Python-3.5.4.tgz
$ cd Python-3.5.4
$ ./configure
$ make
$ sudo make install
```





## Chanage Welcomde Message

- 저장장치 사용량을 출력하는 스크립트 작성한다.
- `/etc/update-motd.d` 디렉토리 안에 스크립트 문서를 저장한다.

```bash
$ sudo vi /etc/update-motd.d/99-dist-usage
#!/bin/bash
echo -e "\033[0;34m" "--------------------------------------------------------"
echo -e "\033[0;34m" "-------               DISK Usage                 -------"
echo -e "\033[0;34m" "--------------------------------------------------------"
echo -e "\033[0;31m" " > DISK Remain : $(df -P | grep -v ^Filesystem | awk '{sum += $4} END { print sum/1024/1024 " GB" }')"
echo -e "\033[0;33m" " > DISK Used   : $(df -P | grep -v ^Filesystem | awk '{sum += $3} END { print sum/1024/1024 " GB" }')"
echo -e "\033[0;32m" " > DISK Total  : $(df -P | grep -v ^Filesystem | awk '{sum += $2} END { print sum/1024/1024 " GB" }')"
echo -e "\033[0;34m" "--------------------------------------------------------"
echo -e "\033[1;37m"

```



- 파일명 앞자리에 숫자의 순서대로 실행된다.

```bash
$ sudo ls /etc/update-motd.d/
00-header     51-cloudguest  90-updates-available  97-overlayroot      99-dist-usage
10-help-text  80-esm	     91-release-upgrade    98-fsck-at-reboot
50-motd-news  80-livepatch   95-hwe-eol		   98-reboot-required
```



- 다시 로그인하면 아래 처럼 메시지가 출력된다.

```bash
...

 --------------------------------------------------------
 -------               DISK Usage                 -------
 --------------------------------------------------------
  > DISK Remain : 51.5426 GB
  > DISK Used   : 10.0532 GB
  > DISK Total  : 61.6115 GB
 --------------------------------------------------------
Last login: Fri Mar 13 09:29:07 2020 from 211.228.100.67
$
```



## echo

#### echo color

```bash
White  : echo -e "\033[1;37m"
Black  : echo -e "\033[0;30m"
BLlue  : echo -e "\033[0;34m"
Green  : echo -e "\033[0;32m"
Cyan   : echo -e "\033[0;36m"
Red    : echo -e "\033[0;31m"
Purple : echo -e "\033[0;35m"
Yellow : echo -e "\033[0;33m"
Gray   : echo -e "\033[1;30m"
```







