# Collections

## 컬렉션의 종류 및 특징

| Collections  | Order     | Feature                | Input Item's type |
| ------------ | --------- | ---------------------- | ----------------- |
| Arrays       | ordered   | -                      | Same Type         |
| Sets         | unordered | unique values          | 
| Dictionaries | unordered | key-value associations |


## Mutability of Collections
Mutuability의 뜻은 '변하기 쉬움'이다. Array나 Set이나 Dictionary를 생성하고 `변수`에 할당하면 컬렉션은 mutual 형으로 생성이 된다. 쉽게 말하면 생성한 뒤에 아이템을 추가, 삭제, 변경(mutable)할 수 있음을 뜻한다. 하지만, 컬렉션을 `상수`에 할당하면 컬렉션의 사이즈나 내용물을 변경할 수 없다.(immutable)
변경할 일이 없다면 `상수`로 선언하는 것이 바람직하다. 문제 발생을 사전에 막을 수 있고 Swift 컴파일러의 최적화에 도움을 준다.

## Array
문법

```Swift
  var classicInts = Array<Int>()
  classicInts.append(1)
  classicInts.append(2)
  classicInts.append(3)

  var moreSimpleInts = [Int]()
  moreSimpleInts.append(1)
  moreSimpleInts.append(2)
  moreSimpleInts.append(3)
```

두 방법은 기능적으로 완전히 동일하다. 하지만, 두 번째 방법을 권한다.
`[Int]`에 적은 Int 때문에 이 배열에는 Int Type의 아이템만 담을 수 있다.

```Swift 
  var myInts = [Int]()
  myInts = []
```

`[]`는 ***empty array literal*** 이다. 위 코드를 실행하면 myInts는 텅빈 배열이 된다. 하지만 여전히 담을 수 있는 타입은 Int다.


## 초기값으로 배열 생성

10개의 아이템을 넣을 수 있고 초기값은 0.0인 배열 만들기  

```
  var tenDoubles = Array(repeating: 0.0, count: 10)
```

## 두 배열 합치기

```
  var firstDoubles = Array(repeating: 1, count: 5)
  var secondDoubles = Array(repeating: 2, count: 5)
  var sumDoubles = secondDoubles + firstDoubles
  // output -> "[2, 2, 2, 2, 2, 1, 1, 1, 1, 1]"
```

## 배열 리터럴(array literal)로 생성하기

배열 리터럴의 생김새 

```Swift
  [value1, value2, value3]
```

아래 코드는 "문자열을 담는 배열 colorList를 생성하는데, 초기값으로 "Red", "Green", "Blue" 3개를 넣어둔다"라는 의미다.

```Swift
  var colorList: [String] = ["Red", "Green", "Blue"]
```







 










