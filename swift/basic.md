# Type Casting
Swift에서 형변환은 `is` 또는 `as` 연산자를 사용한다. 이 두 개의 연산자로 변수의 형을 체크하거나, 다른 형으로 변환하는 일을 쉽게 할 수 있다. 


# Optional Values

출처 : [Understanding Optional Values in Swift - Craig A. Will](http://swiftjester.org/papers/understanding-optional-values-in-swift.htm)

개발할 때, 어떤 변수에 값이 잘 들어있다고 기대했다가 실제로는 값이 들어있지 않았을 때 에러가 발생한다.

iOS나 MAC에서 "값이 없음"을 ```nil```로 표현한다. 예를 들면, ```toInt()``` 함수는 "1234"가 아닌, "abcd"가 주어지면 ```nil```을 반환한다.

Swift는 ```optional values``` 또는 ```optionals```라는 기능을 제공하는데, 이를 통해 개발자는 ```nil```을 피하거나 에러를 재빨리 처리할 수 있다.


```type safty```가 정확한 변수의 형을 보장하여 개발자가 실수하는 것을 막는다면, ```optionals```와 같이 "값이 없음"에 대한 안전성을 보장하는 것은 ```value safty```라고 할 수 있다.

일반 변수(non optionals)는 초기값을 갖고 있어야 한다. 만약, 이후에 ```nil```로 바뀐다면 런타임 에러를 일으킬 수 있다. 변수에 ```nil```과 같은 "값이 없음"을 허용하려면 ```optional``` 데이터 형으로 선언을 해야 한다.

Optional로 선언하는 방법

```Swift
  var number: Optional<Int>  
  number = nil
```

또는,

```Swift
  var number: Int?
  number = nil
```

```number```는 optional value이므로 ```nil```을 가질 수 있다. 만약 일반 변수로 선언하고 ```nil```로 바꾸려하면 에러가 발생한다.

```Swift
  var number: Int
  number =  nil 
  
  error: nil cannot be assigned to type 'Int'
  n2 =  nil
```

Optional 타입의 변수에 값을 넣으면 "이 값은 ```wrapped``` 되어 있다"고 표현한다. 이는 일반적인 방법으로는 변수에 접근할 수 없고, 접근하려면 변수를 ```unwrapped``` 시켜야 한다는 것으로 이해하면 된다.

아래 코드는 에러가 발생할 수 있다.

```Swift
  var number: Int? = 10
  var temp = number
```

```number``` 강제로 unwrapped 하는 방법은 ```!```를 붙이면 된다.

```Swift
  var number: Int? = 10
  var temp = number!
```

하지만, 이 방법은 number가 ```nil```이 절대 아닐 경우에만 안전하다.
가장 좋은 방법은 ```optional binding```이라 불리는 방법이고, 아래와 같이 구현하면 된다.

```Swift
  var number: Int? = 10
  if let p = number {
      print("The unwrapped value is\(p)")
  } else {
      print("There is no value")
  }
 
```

위의 코드는 if문에서 wrapped value인 ```number```의 실제 값을 ```p```에 대입해보고, 성공하면 첫 번째 구문을, 실패(no value, nil)하면 두 번째 구문을 실행하게 된다.

물론 아래처럼 ```nil```을 체크하는 방법으로 구현할 수 있다.

```Swift
  var number2:Int? = 10
  if number2 != nil {
    print("The value is \(number2!)")
  } else {
    print("m has no value")
  }
```

값이 있다고 해서 ```!```로 강제 unwrapped을 하고 있는 것을 주목하자. 개발자가 ```!```를 깜빡하는 순간 에러를 발생 시킬 수 있기 때문에 이 방법보다는 ```optional binding```을 사용하는 것이 좋다.



# Closures

Swift의 클로저는 아래와 같이 생겼다.

```Swift
	{ 
		([parameter]) -> [return type] in
		statements
	}
```

```Swift
	var animals = ["dog", "cat", "horse", "cow", "zebra"]
	print(animals)
```

> **출력: ["dog", "cat", "horse", "cow", "zebra"]**

array가 갖고 있는 sort()를 호출해보자.

```Swift
	var animals = ["dog", "cat", "horse", "cow", "zebra"]
	animals.sort()
	print(animals)
```

> **출력: ["cat", "cow", "dog", "horse", "zebra"]**

아주 간단하게 오름차순 정렬이 되었다.

이제, 내림차순 정렬을 하자.
다른 언어와 비슷하게, 정렬에 사용할 함수(backward(...))를 정의하고 sort()로 넘겨준다.

***"sort 함수야 정렬할 때, 이 함수를 사용해줘!"라고 이해하면 된다.***

```Swift
	var animals = ["dog", "cat", "horse", "cow", "zebra"]
	func backward(_ s1: String, _ s2: String) -> Bool {
	  return s1 > s2
	}
	animals.sort(by: backward)
	print(animals)
```

> **출력: ["zebra", "horse", "dog", "cow", "cat"]**

backward()를 이곳저곳에서 사용하면 위와 같이 하나 정의해두고 써도 되지만 그닥 중요하지 않거나
간단하게 한 곳에서 사용한다면 클로저를 사용하는게 편하다.

```Swift
	var animals = ["dog", "cat", "horse", "cow", "zebra"]
	// 클로저는 by: 뒤에 '{'부터 시작
	// 그 다음 '('에서 ')'까지가 parameter
	// '-> Bool' 이므로 return type은 Bool
	// 'in' 뒤에 나오는 구문이 이 클로저가 할 일 (역순정렬을 위한 비교문)
	animals.sort(by: {(_ s1: String, _ s2: String) -> Bool in
	  return s1 > s2
	})
	print(animals)
```

> **출력: ["zebra", "horse", "dog", "cow", "cat"]**

클로저를 아래와 같이 간단하게 사용할 수 있다.  
parameter type과 return type을 생략했다.  
결과는 동일하다.

```Swift
	var animals = ["dog", "cat", "horse", "cow", "zebra"]
	animals.sort(by: {s1, s2 in
	  return s1 > s2
	})
	print(animals)
```

> **출력: ["zebra", "horse", "dog", "cow", "cat"]**

충격적인 사실은 더더 줄일 수 있다.  
이것도 돼고,

```Swift
  animals.sorted(by: {
    $0 > $1
  })
```

심지어 이것도 된다.

```Swift
  animals.sorted(by: >)
```

#### Closure 정의
typealias로 지저분한(?) 클로저를 Type으로 정의한다.

```Swift
  public typealias MyClosure = (String, Int) -> Void
```

이제 MyClosure로 변수를 만들 수 있다.

```Swift
  var myClosure: MyClosure
```
