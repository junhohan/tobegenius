### Optional Values

출처 : [Understanding Optional Values in Swift - Craig A. Will](http://swiftjester.org/papers/understanding-optional-values-in-swift.htm)

개발할 때, 어떤 변수에 값이 잘 들어있다고 기대했다가 실제로는 값이 들어있지 않았을 때 에러가 발생한다.

iOS나 MAC에서 "값이 없음"을 ```nil```로 표현한다. 예를 들면, ```toInt()``` 함수는 "1234"가 아닌, "abcd"가 주어지면 ```nil```을 반환한다.

Swift는 ```optional values``` 또는 ```optionals```라는 기능을 제공하는데, 이를 통해 개발자는 ```nil```을 피하거나 에러를 재빨리 처리할 수 있다.


```type safty```가 정확한 변수의 형을 보장하여 개발자가 실수하는 것을 막는다면, ```optionals```와 같이 "값이 없음"에 대한 안전성을 보장하는 것은 ```value safty```라고 할 수 있다.

일반 변수(non optionals)는 초기값을 갖고 있어야 한다. 만약, 이후에 ```nil```로 바뀐다면 런타임 에러를 일으킬 수 있다. 변수에 ```nil```과 같은 "값이 없음"을 허용하려면 ```optional``` 데이터 형으로 선언을 해야 한다.

Optional로 선언하는 방법

```
  var number: Optional<Int>  
  number = nil
```

또는,

```
  var number: Int?
  number = nil
```

```number```는 optional value이므로 ```nil```을 가질 수 있다. 만약 일반 변수로 선언하고 ```nil```로 바꾸려하면 에러가 발생한다.

```
  var number: Int
  number =  nil 
  
  error: nil cannot be assigned to type 'Int'
  n2 =  nil
```

Optional 타입의 변수에 값을 넣으면 "이 값은 ```wrapped``` 되어 있다"고 표현한다. 이는 일반적인 방법으로는 변수에 접근할 수 없고, 접근하려면 변수를 ```unwrapped``` 시켜야 한다는 것으로 이해하면 된다.

아래 코드는 에러가 발생할 수 있다.

```
  var number: Int? = 10
  var temp = number
```

```number``` 강제로 unwrapped 하는 방법은 ```!```를 붙이면 된다.

```
  var number: Int? = 10
  var temp = number!
```

하지만, 이 방법은 number가 ```nil```이 절대 아닐 경우에만 안전하다.
가장 좋은 방법은 ```optional binding```이라 불리는 방법이고, 아래와 같이 구현하면 된다.

```
  var number: Int? = 10
  if let p = number {
      print("The unwrapped value is\(p)")
  } else {
      print("There is no value")
  }
 
```

위의 코드는 if문에서 wrapped value인 ```number```의 실제 값을 ```p```에 대입해보고, 성공하면 첫 번째 구문을, 실패(no value, nil)하면 두 번째 구문을 실행하게 된다.

물론 아래처럼 ```nil```을 체크하는 방법으로 구현할 수 있다.

```
  var number2:Int? = 10
  if number2 != nil {
    print("The value is \(number2!)")
  } else {
    print("m has no value")
  }
```

값이 있다고 해서 ```!```로 강제 unwrapped을 하고 있는 것을 주목하자. 개발자가 ```!```를 깜빡하는 순간 에러를 발생 시킬 수 있기 때문에 이 방법보다는 ```optional binding```을 사용하는 것이 좋다.



### Closures

```Swift
	{ ([parameter]) -> [return type] in
		statements
	}
```

