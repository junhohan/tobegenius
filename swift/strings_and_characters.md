# Strings and Characters
## Overview
- Swift에서는 문자열을 ```String``` Type으로 표현
- ```String```에 담은 내용에 접근하는 방법은 다양하다.
- 빠르다.
- 최근 트랜드에 맞춰 구현됐다.
- 유니코드 문자열 인코딩에 기반한다. (encoding-independent Unicode characters)


> Swift의 `String`은 파운데이션 클래스인 `NSString`과 연결되어있다. Foundation은 `String`을 확장하여 `NSString`에 정의한 메서드를 제공하는데, 이 때문에 형변환 없이 `NSString`의 함수를 그래도 사용할 수 있다.

## String Literals
문자열 리터럴로 미리 정의된 문자열 값을 넣을 수 있다.

```
  let someString = "This is the predefined String Literal Value"
```

Swift에서 문자열 리터럴을 넣으려하면 변수는 알아서 `String`형으로 파악(추론, 간주)한다.

비어있는 문자열은 빈 문자열 리터럴을 사용해도 되고, 
initializer를 사용할 수 있다.
둘 다 empty 상태로 동일하다.

```
  let empty1 = ""        // empty string literal
  let empty2 = String()  // init using initializer syntax
```

문자열 변수에 아무런 값이 없는지 확인하려면,

```
  if someString.isEmpty {
    print("I'm empty")
  }
```

## String Mutability
`Mutability`는 '변하기 쉬움'이란 뜻이다.  
특정 문자열을 변수(var)에 넣으면 변경이 가능하고, 상수(let)에 넣으면 변경이 불가능하다.

```
  var iAmMutable = "ABC"
  iAmMutable += "DEF"     // Possible

  var iAmImmutable = "GHI"
  iAmImmutable += "JKL"   // Impossible
```

> Object-C와 Cocoa에서 문자열의 변경을 허용할 때는 `NSMutableString`을  
> 문자열의 변경을 막아야 할 때는 `NSString`을 사용해야하는 것에 비하면 양반이다!!!!   





[참고 : Apple Inc. ‘The Swift Programming Language (Swift 3.1).’ iBooks.]