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
* 실행할 스크립트는 실행이 가능한지 확인한다. `$ chmod +x my_script`
