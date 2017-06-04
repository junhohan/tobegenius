# Collections

## 컬렉션의 종류 및 특징

| Collections  | Order     | Feature                | Input Item's type |
| ------------ | --------- | ---------------------- | ----------------- |
| Arrays       | ordered   | -                      | Same Type         |
| Sets         | unordered | unique values          |                   | 
| Dictionaries | unordered | key-value associations |                   |


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

### 비어있는 배열 생성하기
```Swift 
  var myInts = [Int]()
  myInts.append(0)
  myInts.append(1)
  myInts = []
```

`[]`는 ***empty array literal*** 이다. 위 코드를 실행하면 myInts는 텅빈 배열이 된다. 하지만 여전히 담을 수 있는 타입은 Int다.


### 초기값으로 배열 생성

10개의 아이템을 넣을 수 있고 초기값은 0.0인 배열 만들기  

```
  var tenDoubles = Array(repeating: 0.0, count: 10)
```

### 두 배열 합치기

```
  var firstDoubles = Array(repeating: 1, count: 5)
  var secondDoubles = Array(repeating: 2, count: 5)
  var sumDoubles = secondDoubles + firstDoubles
  // output -> "[2, 2, 2, 2, 2, 1, 1, 1, 1, 1]"
```

### 배열 리터럴(array literal)로 생성하기

  > 배열 리터럴의 표기법 : [value1, value2, value3]

아래 코드는 "문자열을 담는 배열 colorList를 생성하는데, 초기값으로 "Red", "Green", "Blue" 3개를 넣어둔다"라는 의미다.

```Swift
  var colorList: [String] = ["Red", "Green", "Blue"]
```

더 간단한 방법으로도 구현할 수 있다.

```Swift
  var colorList = ["Red", "Green", "Blue"]
  var myScore = [9.0, 10, 8, 7]
  var newScore: Double = 9
  myScore.append(newScore)
```

Swift의 타입추론(Type Inference) 덕에 배열의 타입을 명시하지 않아도 colorList에 담을 수 있는 아이템의 형은 String으로, myScore은 Double로 지정된다. 

* 참고 : '추론'한다는 것은 집어넣으려는 값의 형태를 보고, 컴파일러가 알아서 변수의 타입을 알아내는 기능을 갖고 있다는 것이다.  
쉽게 말해, C에서는 사람이 `int num = 0`와 같이 "num는 `int`형을 담을 수 있다"고 알려줬었다. 하지만 Swift에서는 변수의 선언을 변수는 `var` , 상수는 `let`으로 통일하고 어떤 값을 넣으면 컴파일러가 '어떤 값'이 무슨 타입인지 알아내고 변수의 타입을 알라서 지정한다 생각하면 된다.

* 참고 : 아이템 중, 한 개라도 Double형(9.0)이 존재하면 myScore는 Double형을 담을 수 있는 배열로 추론된다. 모두 정수형이면 Int로 추론된다.

### 배열에 접근하고 수정하기

배열의 아이템 개수

```Swift
  print("Count = \(colorList.count)")
  // Output : Count = 3
```

배열이 비어있는지 확인

```Swift
  var users = [String]()
  if users.isEmpty {
    print("You have no users!!")
  }
```

배열에 아이템 추가하기
```Swift
  users.append("Lily Ellen")
  if users.isEmpty == false {
    print("Congrat! You have some users!!")
  }
```

`+=` 연산자로도 아이템을 추가할 수 있다.

```Swift
  users += ["Amy Ree"]
  users += ["Faramore", "Adele"]
  if users.count > 1 {
    print("Wow! You have so many users!!")
  }
```

값에 접근하는 것은 여러 언어와 다를바 없다.

```Swift
  var firstUser = users[0]  // "Lily Ellen"
```

값 변경도 큰 차이 없다.

```Swift
  users[0] = "Lily Allen"
  print("You fixed typo, from Ellen to Allen")
```

Subscript Syntax를 이용해서 여러 요소를 한 번에 수정할 수 있다.

```Swift
  users[1...2] = ["Amy Lee", "Paramore"]
  print("You fixed two typo of index from 1 to 2")
  // users = ["Lily Allen", "Amy Lee", "Paramore", "Adele"]
```

Subscript Syntax로는 현재 갖고 있는 아이템들만 수정할 수 있고, 새로운 아이템을 추가할 수는 없다.

```Swift
  users[5...6] = ["Amy Lee", "Paramore"]  // Compile Error
```

지정한 인덱스에 새로운 아이템 추가하기

```Swift
  users.insert("Gwen Stefani", at: 1)
  // users = ["Lily Allen", "Gwen Stefani", "Amy Lee", "Paramore", "Adele"]
```

아이템 삭제하기

```Swift
  var adele = users.remove(at: 4)
```
위 코드를 실행하면,  

* 4번째 인덱스의 "adele" 삭제되고,
* 이제 users의 아이템의 개수는 4개가 되며,
* 삭제된 "adele"은 return 되어 `var adele` 변수에 저장된다.

마지막 아이템 삭제하기
`removeLast()`를 사용하면, 삭제하기 전에 배열의 마지막 개수를 체크할 필요가 없고, `remove()`와 동일하게 삭제한 아이템을 반환하기 때문에 잘 이용하면 `stack`처럼 사용할 수 있다.

```Swift
  var paramore = users.removeLast()
  // "paramore" 삭제됨
```

배열 순회하기

`for-in Loop`를 사용하면 배열의 요소를 처음부터 끝까지 접근할 수 있다.

```Swift
  for user in users {
    print(user)
  }
  // [Output]
  // Lily Allen
  // Gwen Stefani
  // Amy Lee
  // Paramore
```

배열의 숫자 인덱스가 필요한 경우에는 `enumerated()`함수를 사용한다.
이 메소드는 숫자 인덱스와 아이템을 짝지어 `tuple` 형태로 반환한다.

```Swift
  for (index, value) in users.enumerated() {
    print("\(index) : \(value)")
  }
  // [Output]
  // 0 : Lily Allen
  // 1 : Gwen Stefani
  // 2 : Amy Lee
```


## Set



```Swift

```



## Dictionary

`Dictionary`는 **한 가지 타입의 `Key`와 한 가지 타입의 `Value`의 쌍**을 순서와 무관하게 저장한다. 각각의 값은 유니크한 `Key`와 연결된다. 그러므로, Key는 딕셔너리 안에서 Value를 검색하기 위한 식별자 역할을 한다.

### Dictionary를 사용하는 경우

> 구현하려는 내용이 저장 순서와 크게 상관없을 때
> 식별자(Identifier)로 검색을 해야할 때

실제 사전을 이해하면 어렵지 않다. 사전에서 검색하려는 단어, "Student"는 `Key`이고, 해당 단어의 뜻, "학생"은 `Value`이다.

### Dictionary의 두 가지 형태 

> `Dictionary<Key, Value>` 또는  `[Key: Value]` 

두 방법은 서로 완전히 동일한 기능을 하는데, 두 번째 간략한 형태를 많이 쓴다.


### 텅빈 Dictionary 만들기

```Swift
	var fruits = [Int: String]()
```

### Empty Dictionary Literal

`[:]`를 이용하면 Dictionary 변수를  다시 생성할 수 있는데, Dictionary 타입이 이미 정해진 경우에만 사용할 수 있다.

```Swift
	var fruits = [Int: String]()
	fruits = [:]
```

fruits 변수를 처음 생성할 때, 숫자 키와 문자열 값을 저장하겠다고 타입을 지정했다.
이후에 Empty Dictionary Literal인 `[:]`를 대입하면 텅빈 Dictionary가 된다.

> Swift3.1 공식문서에서 `[:]`를 대입하는 행위를 `initial`이 아닌 `create`라고 표현했다.

아래 경우 처럼 타입을 미지정한 상태로는 사용이 불가능하다.

```Swift
   var fruits = [:]
   // error: empty collection literal requires an explicit type
```

### Empty Dictionary Literal

문법의 형태

```Swift
  [Key1: Value1, Key2: Value2, ... KeyN: ValueN]
```

사용 예

```Swift
   var fruitsColor: [String: String] = ["Apple": "Red", "Oreange": "Orange", "Banana": "Yellow"]
```

간편하게

```Swift
   var fruitsColorSimple = ["Apple": "Red", "Oreange": "Orange", "Banana": "Yellow"]
```

모든 Key값의 타입이 같고, 모든 Value의 타입이 같으므로, Swift 컴파일러는 fruitsColorSimple 변수는 `[String: String]` 형태의 Dictionary라는 것을 추론할 수 있다.

### Dictionary 접근하기

저장한 개수는 `count` 프로퍼티로 알 수 있다.

```Swift
  print(fruitsColor.count)
  // [Ouput]
  // 3
```

`isEmpty` 프로퍼티로 텅비어있는지 확인할 수 있다.

```Swift
  print(fruitsColor.isEmpty)
  // [Ouput]
  // false
```

### Dictionary 수정하기

새로운 Key 값과 Value를 입력하면 Dictionary에 아이템을 추가할 수 있다.

```Swift
  fruitsColor["WaterMelon"] = "Dark Green"
  // [Ouput]
  // ["Banana": "Yellow", "Oreange": "Orange", "WaterMelon": "Dark Green", "Apple": "Red"]
```







