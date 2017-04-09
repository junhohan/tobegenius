# How Windows Work
## NSWindow Class
- 화면에 표현되는 윈도우를 관리하는 기능을 구현해 놓음
- 하나의 NSWindow는 하나의 윈도우로 생각하면 됨
- 주요 기능 2가지
  - 수 많은 NSView가 위치할 영역 제공
  - 마우스나 키보드 등의 사용자 이벤트를 받거나, 분배하는 역할

> Window는 때로,  
>  - Application Kit Object로 불림  
>  - 윈도우 서버의 디스플레이 장치(the window server’s display device)로 불림  

NSWindow 객체는  
타이틀바, 가장자리(border) 등 모든 윈도우를 아우르는 Frame Rectangle과
컨텐츠 영역을 관장하는 Content Rectangle에 의해 구현된다.  
두 사각형 영역은 정수형의 화면 좌표 시스템에 의해 관리된다.

일반적으로 Interface Builder를 이용해 윈도우를 생성하는데, 위치 지정, 윈도우 속성 설정, 다양한 뷰의 레이아웃를 잡는 등의 작업을 할 수 있다. 구체적으로 화면 On/Off, 윈도우 타이틀 변경, 모달 윈도우 띄우기, 윈도우 상태(closing, zooming, resizing 등)를 모니터링하기 위한 delegate 등록 등을 할 수 있다.

## Creating a window programmatically
윈도우의 initializers를 이용하면, Code 레벨에서 윈도우를 생성할 수 있다.
이때, 윈도우 속성 Content Rectangle의 크기와 위치, Frame Rectangle은 Content Ractangle 영역에 따라 결정된다.

> 윈도우가 생성되면 자동으로 2개의 뷰가 생성되는데,  
> - opaque frame view : Frame Rectangle을 채우고, 타이틀바와 보더 등이 그려지는 뷰. Frame view와 그 주변의 뷰들은 직접 접근할 수 없다.
> - transparent content view : Content Rectangle을 채우는 뷰. Contnet View는 아주 쉽게 접근이 가능한데, setContentView: 함수를 사용하면 default content view를 지우고 직접 만든 뷰로 변경할 수도 있다. Content View의 위치는 윈도우가 관장한다. 때문에 NSView의 setFrame으로 시작하는 함수들로는 위치를 지정할 수 없다. 대신, NSWindow의 위치 지정을 위한 함수들을 사용해야 한다. [참고 : Opening and Closing Windows](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/WinPanel/Tasks/OpeningClosingWindows.html#//apple_ref/doc/uid/20000226-CJBCCCEF)

## Subview
NSView는 addSubView 함수를 제공한다.  
이 함수를 사용하면 Content View에 Subview를 추가할 수 있다. 또한, 그 Subview의 Subview를 추가할 수도 있다. 이러한 뷰의 Tree 구조를 "Window View Hierarchy"라고 부른다. View Hierarchy의 최상위의 뷰에 `display...` 메시지를 전달하면 윈도우에게 화면에 표시하라는 명령을 내릴 수 있다.  
뷰를 화면에 표시하는 것은 이미 결정되어 있는 순서에 맞춰서 실행되기 때문에 가장 먼저 그려져 있는 Content View는 전체적으로 또는 부분적으로 서브뷰에 의해 가려진다. 당연히 이러한 서브뷰들은 각자 지니고 있는 서브뷰에 의해 가려진다.

