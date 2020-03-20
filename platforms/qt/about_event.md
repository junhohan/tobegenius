# The Event System

참고 : [The Event System](https://doc.qt.io/archives/qt-4.8/eventsandfilters.html)

> Qt에서 Event는 QEvent 추상 클래스에서 파생된 Object다.  어플리케이션 내부나 바깥에서 발생한 사건의 결과를 알려주는데 사용된다. `QObject`를 상속받은 인스턴스는 이러한 이벤트를 받아서 처리할 수 있고, 특히 Widget과 깊게 연관되어있다.



## 이벤트는 어떻게 전달될까?

- 이벤트가 발생하면?

  - Qt는  `QEvent`의 서브클래스 중 적당한 녀석을 골라 이벤트 정보가 담긴 인스턴스를 생성한다.
  - 특정 `QObject` 또는 이를 상속받은 인스턴스의 `event()` 함수를 호출하는 방식으로 이벤트를 전달한다.

- `event()` 함수는?

  - `event()` 함수는 이벤트 자체를 처리(handle)하지 않는다. 

  - 전달 된 이벤트의 유형에 따라 해당 유형을 위한 이벤트 핸들러를 호출한다.

  - 이벤트가 승인되었는지 또는 무시되는지에 따라 응답을 보낸다.

  - [QMouseEvent](https://doc.qt.io/archives/qt-4.8/qmouseevent.html) and [QKeyEvent](https://doc.qt.io/archives/qt-4.8/qkeyevent.html)와 같은 이벤트는 윈도우 시스템으로부터 전달된다.
  - [QTimerEvent](https://doc.qt.io/archives/qt-4.8/qtimerevent.html)와 같은 이벤트는 다른 코드로부터 전달된 이벤트다.
  - 그 외의 이벤트는 어플리케이션 자체에서 전달된다.



## 이벤트 타입

대부분의 이벤트 타입은 특별한 클래스를 갖는다. ([QResizeEvent](https://doc.qt.io/archives/qt-4.8/qresizeevent.html), [QPaintEvent](https://doc.qt.io/archives/qt-4.8/qpaintevent.html), [QMouseEvent](https://doc.qt.io/archives/qt-4.8/qmouseevent.html), [QKeyEvent](https://doc.qt.io/archives/qt-4.8/qkeyevent.html) [QCloseEvent](https://doc.qt.io/archives/qt-4.8/qcloseevent.html) 등)



각각의 클래스는 [QEvent](https://doc.qt.io/archives/qt-4.8/qevent.html) 를 상속받고 각 이벤트에 특화된 함수가 추가되어있다. 예를 들면 [QResizeEvent](https://doc.qt.io/archives/qt-4.8/qresizeevent.html)에는 [size()](https://doc.qt.io/archives/qt-4.8/qresizeevent.html#size) 함수와 [oldSize()](https://doc.qt.io/archives/qt-4.8/qresizeevent.html#oldSize)가 구현되어있어 이벤트를 받은 위젯이 크기가 얼마나 어떻게 변경되었는지 알 수 있게 돕는다.



 [QMouseEvent](https://doc.qt.io/archives/qt-4.8/qmouseevent.html)의 경우, 마우스를 누른 상태, 더블 클릭한 사건, 마우스 이동 등 한 개 이상의 이벤트 타입을 제공한다.



[QEvent::Type](https://doc.qt.io/archives/qt-4.8/qevent.html#Type-enum)은 Qt에서 제공하는 이벤트 유형을 나열한 `enum` 테이블이다. 전달 받은 이벤트에는 이 값이 입력되어있어 런타임 시 어떤 타입의 이벤트인지 신속하게 판별할 수 있다.

  

이벤트에 대한 좀 더 깊이 있는 내용은  [QCoreApplication::notify](https://doc.qt.io/archives/qt-4.8/qcoreapplication.html#notify)() 와 [Another Look at Events](http://doc.qt.digia.com/qq/qq11-events.html)에서 참고할 수 있다.



## 이벤트 핸들러











https://stackoverflow.com/questions/27855137/how-to-disable-the-delivery-of-mouse-events-to-the-widget-but-not-its-children-i





## Qt::WidgetAttribute for Mouse Event

참고 : [Qt5::WidgetAttribute](https://doc.qt.io/qt-5/qt.html#WidgetAttribute-enum)

- 이 속성을 적용하면 위젯과 하위의 요소들은 더 이상 마우스 이벤트를 전달받지 않는다.
- 해당 위젯과 하위 요소들이 위젯 계층에 존재하지 않는 것처럼 마우스 이벤트가  다른 위젯으로 전달된다. 즉, 마우스 이벤트를 포함한 다른 이벤트들은 이 속성이 설정된 위젯을 통과한다.
- 디폴트 값은 `disable`이다.

```C++
QWidget.setAttribute(Qt::WA_TransparentForMouseEvents);
```











## Event in Custom Widget

> `Event Filter` 는 

The event filter will work only for events in your `MyClass` instance, only. Not for its children.

So, events, such as a mouse click or move, in your `qGraph_back` will be not *visible* in your `eventFilter` method.

When you add a child in a widget, an `QChildEvent` event is raised. You can use it to install the *event filter* on all children (and grandchildren, etc.). But, you have to install the event filter on your `MyClass` before adding the children.





https://stackoverflow.com/questions/55986902/how-to-install-event-filter-on-a-custom-qt-class