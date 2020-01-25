# NGINX on Ubuntu





#### Run

```
$ sudo nginx -c /etc/nginx/nginx.conf
```

- [-c] : 설정파일 지정



#### Test Configuration

```
$ nginx -t -c /etc/nginx/nginx.conf
```



#### Reload Configuration

```
$ sudo nginx -c /etc/nginx/nginx.conf -s reload
```

- [-s] : Signal [stop, quit, reopen, reload] (v >= 0.7.53)



#### Stop

```
$ sudo kill -QUIT $(cat /run/nginx.pid)
```



#### References

​	http://nginx.org/en/docs/

​	https://www.keycdn.com/support/nginx-commands

​	https://extrememanual.net/11289

​	https://codeday.me/ko/qa/20190311/42468.html

​	https://www.opentutorials.org/module/384/4526

​	