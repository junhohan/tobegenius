# Flatbuffers (on macOS)

## Overview
- 효율성 높은 크로스플랫폼 직렬화 라이브러리
- C++, C#, C, Go, Java, JavaScript, PHP, and Python 지원
- 구글 내부의 게임게발과 성능평가 어플리케이션을 제작을 위해 작성된 라이브러리
- GitHub에 공개된 오픈소스 (Apache license, v2)

## Pros
- Parsing 또는 Unpacking 과정없이, 직렬화된 데이터에 접근 가능
- 메모리 효율과 속도
  - C++의 경우 데이터에 접근하기 위한 Buffer Size 외에 추가 메모리 필요 없음
  - [속도 벤치마킹 바로가기](https://google.github.io/flatbuffers/flatbuffers_benchmarks.html)
- 유연함
- 적은 코드량과 사용하기 쉬움
- Strongly typed
- Convenient to use
- 의존성 없는 크로스플랫폼 코드
  - C++의 경우 대부분의 최신 컴파일러 사용 가능

## Flatbuffers 사용한 프로젝트
- Cocos2d-x : 게임데이터의 직렬화
- Facebook : 안드로이드앱과 서버와의 통신 [자세한 설명](https://code.facebook.com/posts/872547912839369/improving-facebook-s-performance-on-android-with-flatbuffers/)

## Install

> **$ brew install flatbuffers**  
> **$ brew info flatbuffers**  
> flatbuffers: stable 1.6.0 (bottled), HEAD  
> Serialization library for C++, supporting Java, C#, and Go  
> https://google.github.io/flatbuffers  
> /usr/local/Cellar/flatbuffers/1.6.0 (16 files, 1.5MB) *  

### flatbuffer를 사용하려면?

- FlatBuffer ```schema```를 작성한다.
  - 직렬화할 데이터 구조를 정의하는 단계
  - 각 필드는 int형, float형 등의 ```scalar type```으로 정의할 수 있다.
  - 문자열 및  모든 타입의 배열을 표현할 수 있다.
  - 오브젝트의 레퍼런스, unions로 오브젝트의 묶음을 정의할 수도 있다.
- 작성한  schema를 ```flatc``` 컴파일러로 컴파일한다.
  - 컴파일 후에는 ```myfilename_generated.h``` 파일이 생성된다.
  - 생성된 헤더파일은 핵심기능을 담고 있는 ```flatbuffers.h```만을 포함(depends on)한다.
- 생성된 헤더(Python 등의 경우, 클래스)파일을 include(or import)한 후, 기능을 구현한다.
  - ```FlatBufferBuilder```클래스를 사용하여 ```flat binary buffer```을 생성한다.
  - 헤더에 포함된 함수로 오브젝트를 ```flat binary buffer```에 담을 수 있다.
  - 버퍼를 저장하거나 전송하면 끝!
  - 버터를 다시 읽고 싶다면, 버퍼에서 root 오브젝트의 포인터를 가져다가 ```object->field()```를 호출한다.
 
## schema 작성하기
여기서 사용하는 스키마 언어(일명 IDL;Interface Definition Language)는 C계열 언어와 유사한 형태다.

```C
// example IDL file
namespace MyGame;

attribute "priority";

enum Color : byte { Red = 1, Green, Blue }

union Any { Monster, Weapon, Pickup }

struct Vec3 {
  x:float;
  y:float;
  z:float;
}

table Monster {
  pos:Vec3;
  mana:short = 150;
  hp:short = 100;
  name:string;
  friendly:bool = false (deprecated, priority: 1);
  inventory:[ubyte];
  color:Color = Blue;
  test:Any;
}

root_type Monster;
```
```Weapon, Pickup```에 대한 정의는 생략

### Tables
Flatbuffers에서 오브젝트를 정의하는 기본 방법으로 위에서 ```Monster```에 해당한다.
Monster 안에는 필드 목록을 기재하면 되는데, 각 필드는 자신의 이름과 형 그리고 default 값을 가진다.
(default 값은 옵션. 생략하면 ```0``` 또는 ```NULL```로 채워진다.)

### Structs
```tables```와 유사하지만, 

### Types
지원하는 scalar type  

- 8 bit: ```byte, ubyte, bool```  
- 16 bit: ```short, ushort```  
- 32 bit: ```int, uint, float```  
- 64 bit: ```long, ulong, double```  

지원하는 non-scalar type

- 모든 형을 지원하는 Vector ; ```[type]``` <- 이렇게 표현  
  (Vector를 중첩하는 것은 불가능하지만, ```table```로 inner Vector를 감싸는 형태로 구현할 수 있다.)
- UTF-8 or 7-bit ASCII String 지원  
  (다른 인코딩의 문자열이나 일반적인 binary data는 ```[byte]``` 또는 ```[ubyte]```와 같은 Vector로 정의한다.)
- tables, object, enums, unions 의 ```References Type``` 지원

### Default Values



