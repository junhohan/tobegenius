# Shell Commands
### crontab
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

### 시간 동기화
```
$ date && sudo ntpdate ntp.ubuntu.com && date
```
```
2017. 04. 09. (일) 00:26:51 KST
 9 Apr 00:27:16 ntpdate[20800]: step time server 91.189.91.157 offset 16.050083 sec
2017. 04. 09. (일) 00:27:16 KST
```

[참고페이지](http://system-monitoring.readthedocs.io/en/latest/log.html)