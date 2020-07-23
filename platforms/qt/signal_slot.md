# Signals & Slots

참고 : [Signals & Slots](https://doc.qt.io/qt-5/signalsandslots.html)

> Signal & Slot 은 오브젝트 사이의 통신을 위한 개념으로 Qt의 가장 중요한 매커니즘이며 다른 프레임워크가 제공하는 것과 크게 대비되는 개념이다. Signal & Slot은 Qt의 [meta-object system](https://doc.qt.io/qt-5/metaobjects.html)을 통해 작동한다.



GUI 프로그래밍을 하다보면 하나의 Widget이 변경되었음을 다른 Widget에 알려주고 싶을 때가 많다. 예를 들면 사용자가 `Close` 버튼을 누를 때 윈도우의 `Close()` 함수가 호출되도록 통신하는 것이다.



다른 프레임워크나 툴킷에서 콜백함수를 사용하기도 하지만 이는 직관적이지 않으며 콜백 함수로 전달된 인수의 유형이 올바른지 확인해야하는 어려움이 있다.



Qt에서는 콜백 기법을 대신할 `Signals & Slots` 기법을 지원한다. 특정 이벤트가 발생하면 `Signal`을 방출(emit)한다. Qt의 위젯에는 수 많은 Signal이 미리 정의되어 있고 직접 정의한 Signal을 추가하기 위해 위젯을 상속받을 수도 있다.

`Slot`은 특정 `Signal`에 응답하기 위해 호출되는 함수다. Qt 위젯은 Signal과 같이 미리 정해진 다양한 Slot을 갖고 있다. 하지만, 일반적으로는 받아서 처리해야하는 Signal을 위해 위젯을 상속받고 직접 슬롯을 추가하여 구현한다.



![출처 https://doc.qt.io](https://doc.qt.io/qt-5/images/abstract-connections.png)





### Signals & Slots 의 장점

- Type Safe
  - Signal의 시그너처는 반드시 Slot의 시그너처와 매칭이 되어야 한다.
    - 정확히는 Slot의 시그너처는 추가 인수를 무시할 수 있기 때문에 수신된 Signal의 시그너처보다 짧아도 된다.
  - 시스너처는 비교가 가능하기 때문에 컴파일러가 함수 포인터를 기반으로한 Syntax를 사용할 때 **타입의 불일치**를 감지할 수 있다. 문자열 기반의 Signal & Slot Syntax를 사용할 경우에 타입 불일치는 런타임시에 감지된다.
  - Signal 과 Slot은 인수의 개수에 제한이 없으며, 인수는 완벽하게 Type Safe하다.
- loosely coupled (느슨한 연결)
  - 하나의 클래스가 Signal을 방출할 때는 어떤 Slot이 이를 받아서 처리할지 전혀 모르고 알 필요도 없다.
- 정확한 호출
  - Qt는 Signal에 연결된 Slot이 정확한 시점에 호출될 것을 보장한다.



