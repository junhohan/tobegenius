# About QT

참고 : [About Qt](https://wiki.qt.io/About_Qt)



> QT는 Cross-Platform 어플리케이션 개발을 위한 프레임워크다.
>
> 데스크탑, 임베디드 또는 모바일을 위한 어플리케이션 작성할 수 있다.



### Surpported Platforms

- Linux, macOS, Windows
- VxWorks
- QNX
- Android, iOS, BlackBerry
- SailFish OS
- etc



### Special Feature

- QT는 프로그래밍 언어가 아니라 C++로 작성된 플랫폼이다.
- MOC(Meta-Object Compiler)라는 전처리기(preprocessor)는 Signals-and-Slots이라는 형태로 C++ 언어를 확장하는데 사용된다.
- 컴파일 단계 이전에 MOC는 Qt-extended C++를 분석(parse)해서 표준 호환 C++ 코드를 생성한다. 따라서, 프레임 워크 자신과 이 프레임워크를 사용하는 어플리케이션(또는 라이브러리)은 Clang, GCC, ICC, MinGW 및 MSVC와 같은 표준 호환 C++ 컴파일러로 컴파일 할 수 있다.



### Build System

- qmake

  - Qt가 제공하는 자체 빌드 시스템이다.
  - GNU Make, Visual Studio, Xcode와 같은 platform-native 빌드 시스템을 위한 cross-platform 프론트엔드이다.

  

  > qmake를 대신해 Qt 프로젝트를 빌드할 때 CMake를 많이 사용한다.



### Qt Creator

- Qt는 Qt Creator라는 IDE(Integrated Development Environment)를 함께 제공한다.
- Linux, OSX, Windows를 지원하고 자체 Intelligent code completion과 systax highlighting 기능을 제공한다.



### Qt Quick

- Qt로 GUI를 만들 때 Qt Quick 모듈을 사용할 수 있다.
- Qt Quick으로 GUI를 만들면 QML이라는 언어로 작성한다.
- Qt Quick은 QML로 GUI를 생성하기 위한 다양한 모듈을 제공한다.



### QML

- QML은 절차적(procedural) 프로그래밍을 위한 Javascript를 통합하는 선언적 객체 기술(declarative object description language) 언어다.
- QML로 어플리케이션 전체를 작성할 수 있지만, 보통은 GUI는 QML로 작성하고 나머지는 C++로 작성한다.



### Language Bindings

- 보틍은 QML과 C++로 어플리케이션을 작성하지만 필요에 따라 다른 언어를 바인딩 할 수 있다.
- Qt 자체에서 지원하지는 않지만 여러 3rd party를 이용해서 바인딩을 할 수 있다.
  - Python 언어를 바인딩하려면  [Riverbank Computing](http://www.riverbankcomputing.co.uk/)에서 제공하는 [PyQt](https://riverbankcomputing.com/software/pyqt)를 사용한다.
  - 다른 언어 바인딩을 위한 자세한 사항은 [Category:LanguageBindings](https://wiki.qt.io/Category:LanguageBindings)을 참고한다.





### Qt Widget & Qt Quick



##### Qt Widget

- Qt Widget Module은 기존의 데스크탑 스타일의 UI를 구성할 때 필요한 **UI 요소**들을 제공한다.
  - UI 요소(Widget) : 레이블, 버튼, 라디오버튼, 시간 또는 날짜 선택, 프로그레스바 등
- QWidget 클래스는 화면을 랜더링하고 사용자 이벤트를 처리하는 Qt의 모든 UI 클래스는 QWidget 클래스를 상속한다.
- 참고 : [Qt Widget](https://doc.qt.io/qt-5/qtwidgets-index.html)



##### Qt Quick

- Qt Quick Module은 QML 어플리케이션을 작성하기 위한 **표준 라이브러리**다.
- [Qt QML](https://doc.qt.io/qt-5/qtqml-index.html) module이 QML 엔진과 언어를 다루는 환경을 제공하고 Qt Quick Module은 QML로 UI를 구성하기 위해 필요한 전반의 기본적인 타입을 제공한다. 예를 들면, 캔버스를 제공하고, 컴포넌트 작성 및 애니메이션효과, 사용자 입력 수신, 데이터 모델 및 뷰 작성 그리고 지연된 오브젝트 인스턴스화를 위한 타입 또한 제공한다.

- Qt Quick 모듈은 두가지 API를 제공한다.
  - QML 언어로 사용자 인터페이스를 작성하기위한 QML 타입을 제공하는 QML API
  - C++ 코드로 QML 애플리케이션을 확장하기위한 C ++ API
- 참고 : [Qt Quick](https://doc.qt.io/qt-5/qtquick-index.html)































































