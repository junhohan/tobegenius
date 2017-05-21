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

# GCD (Grand Central Dispatch)

멀티코어 프로세서를 지원하는 최적화된 어플리케이션을 개발하기위해 애플이 개발한 동시성 및 쓰레드 관리 기법이다. 전신은 **[libdispatch](https://github.com/apple/swift-corelibs-libdispatch)** 라이브러리인데, C언어로 구현한 low-level API(시스템 레벨에서 동작함)다. Mac OS X 10.6, iOS 4 부터 모든 Darwin 플랫폼에서 이 라이브러리를 지원한다. Swift3에서 전면 개편되었다. (C기반의 API에서 Swift에 어울리는 API로 변경되었다.)

### Single-Core vs Multi-Core

Single-Core 기기에서는 시간을 쪼개는 방법으로 동시성(Concurrency)을 구현한다. 운영체제의 스케줄러는 두 가지 일을 동시간에 처리할 수 없으므로 A쓰레스를 처리하다가 어떤 규칙에 의해 A쓰레드를 잠시 멈추고 B쓰레드를 처리하게 된다. 이것을 아주 아주 유명한 말로 Context Switching이라고 한다.

반면에 Multi-Core 기기에서는 동시간에 여러개의 쓰레드를 처리할 수 있다. Single-Core는 일꾼이 1명이지만 Multi-Core에서는 일꾼이 2명, 4명, 8명일 수 있기 때문이다. 

### GCD와 dispatch Queue

GCD는 쓰레드 최상위에 만들어지고, Shared Thread Pool을 관리한다. 우리는 코드블럭 또는 실행할 아이템(Work Item)을 **dispatch queue**에 추가하고 GCD는 어느 녀석을 어느 쓰레드에서 실행할지 결정한다.

GCD는 **DispatchQueue** 클래스를 제공하는데 이를 이용해서 dispatch queue에 실행할 Task를 추가할 수 있다. 추가된 Task는 FIFO 순으로 실행되며 Thread Safe하다. 여기서 Thread Safe하다는 것은 Task를 추가하는데 Thread 관련 문제가 발생하지 않음을 보장한다고 해석하면 된다. 

### Serial Queue vs Concurrent Queue

GCD가 관리하는 Queue는 실행 방식에 따라 두 종류가 나뉘는데, Serial Queue와 Concurrent Queue다. Serial의 경우 한 시점에 반드시 하나의 Task를 수행함을 보장하고, Concurrent는 여러 개의 Task를 한 번에 수행한다. 물론 먼저 추가된 Task가 먼저 실행되는 것은 보장하지만 어느 Task가 얼마나 걸리는지 누가 먼저 끝나는지는 알 수 없다. 이유는 모든 Core가 무언가를 하고 있다면 새로운 Task는 Queue에서 대기해야하고, 비어있는 Core가 있으면 바로 새로운 Task를 수행하기도 하며 다른 Task를 수행하기 위해 Context Switching을 일으키기도 하기 때문인데, 이 모든 사연들을 GCD가 관리한다.

### GCD의 Queue

GCD는 3가지 형태의 Queue를 제공한다.

- Main queue: 메인쓰레드에서 동작하고 Serial Queue이다.
- Global queues: 시스템 전반에 공유되는 Concurrent queues다. 우선순위에 따라 high, default, low, and background, 4개의 Queue를 관리한다. Background priority queue is I/O throttled.
- Custom queues: Queue를 직접 구현할 수 있는데, Serial이 될 수 있고, Concurrent가 될 수도 있다. 사실상 Global Queue로 흘러들어가서 관리되게 된다.
  
[참고문서1 : raywenderlich.com](https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-1)  
[참고문서2 : wikipedia.org](https://en.wikipedia.org/wiki/Grand_Central_Dispatch)