# Boost::Asio

## Boost Lib

boost는 C++ 개발자들에게 유용한 코드들을 모아놓은 집합이다. 수 많은 게임회사에서 사용하고 있기 때문에 신뢰성과 안정성이 높다. C++11부터 C++ 표준 라이브러리로 추가되었다.

## Boost.Asio

Stands for **A**synchronous **I**nput/**O**utput. C++ 네트워크 프로그래밍에서 주로 사용하는 Boost의 라이브러리 중 하나다. 비동기(Asynchronous) 입출력을 지원하고, 파일 입출력, 시리얼통신 등을 쉽게 개발할 수 있다. 크로스 플랫폼을 지원하고 심지어 iOS, Android에서도 사용할 수 있다.

## Boost 설치 (on macOS)

todo:

## 구현하기

```C++
  #include <boost/asio.hpp>
```

### io_service

* Asio의 핵심 클래스
* 커널에서 발생한 입출력 이벤트를 전달(dispatch)해주는 역할을 한다.
* 네트워크 상의 접속 받기, 접속 하기, 데이터 송/수신 등의 이벤트를 받을 수 있다.
* socket 오브젝트를 생성할 때, is_service를 파라메터로 넘겨준다. 

```C++
  boost::asio::io_service io_service;
```

### endpoint

* 네트워크 주소를 설정한다.

```C++
  boost::asio::ip::tcp::endpoint endpoint( boost::asio::ip::tcp::v4(),
 1003 );
```

### accept

* 클라이언트 접속을 받는 역할을 한다.
* `io_service`와 `endpoint`를 파라메터로 넘겨준다. 

```C++
  boost::asio::ip::tcp::socket socket(io_service);
  acceptor.accept(socket);
```

