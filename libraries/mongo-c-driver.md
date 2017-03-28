# mongo-c-driver

## Install
#### macOS

```BASH
$ brew install mongo-c-driver
```

#### Ubuntu

```BASH
$ git clone https://github.com/mongodb/mongo-c-driver.git
$ cd mongo-c-driver
$ git checkout x.y.z  # To build a particular release
$ ./autogen.sh --with-libbson=bundled
$ make
$ sudo make install
```

### Bulk Insert
이벤트가 발생할 때마다 쓰기를 실행할 경우, 빈번한 I/O가 발생하여 성능을 저하시킨다.  
이를 해결하기 위한 하나의 방법으로 ***버퍼에 모아뒀다가 한 번에 쓰기***를 실행할 수 있는데, 이를 Bulk Write이라고 한다.

[참고 : Bulk Write Operations](http://mongoc.org/libmongoc/current/bulk.html)