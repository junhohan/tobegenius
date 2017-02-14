### Optional Values

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
  
  **error: nil cannot be assigned to type 'Int'**
  **n2 =  nil**

```



 
The fact that a runtime error will result from setting a non optional variable to nil and that nil can only be set to a variable declared with an optional data type might be considered a first line of defense (of two) in avoiding this kind of error.