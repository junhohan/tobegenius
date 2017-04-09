# Foundation
Foundation을 통해 기본적인 오브젝트의 동작, 데이터 타입, 콜렉션(배열, 딕셔너리 등), OS 서비스를 정의한 기초 클래스들의 집합

## Foundation Framework Class의 종류

* 데이터 저장
  -  ```NSData``` : 바이트열을 위한 객체기반 저장소
  -  ```NSValue```, ```NSNumber``` : 간단한 C 데이터열 저장 
  -  ```NSArray```, ```NSDictionary```, ```NSSet``` : 모든 형태의 Object-C 객체를 저장

* 문자, 문자열
  -  `NSString`, `NSMutableString` : 문자열. 검색, 조작, 비교 등을 위한 기능 제공
     - `Scanner` ; NSString에 담긴 숫자, 문자를 스캔할 때 사용
  - `NSCharacterSet` : `NSString`와 `Scanner`가 사용하는데, 문자들을 다양한 방법으로 그룹핑할 수 있다.

* 날짜와 시간
  - `NSDate`, `NSTimeZone`, `NSCalendar` : 시간, 날짜를 담을 있고 각각을 연산하는 기능을 제공한다. 날짜와 시간을 다양한 포멧, 전 세계 지역에 맞게 구현하려면 `NSLocale`과 함께 사용하면 된다.

* 정렬과 필터링
  - `NSArray`, `NSDictionary`, `NSSet`과  `NSPredicate`를 함께 사용하면, 필터링이 가능하고, `NSSortDescriptor`를 사용하여 정렬을 할 수 있다.

* Application Coordination and Timing
  - `NSNotification`, `NotificationCenter`, `NotificationQueue` : 한 객체가 이벤트에 관련된 Observer들에게 이를 Notify할 수 있는 기능을 제공한다. 
  - Timer : 주기적으로 한 객체에서 다른 객체로 메시지를 전달할 수 있다.


* Object Distribution and Persistence
  - `PropertyListSerialization`, `JSONSerialization` : 아키텍처에 독집적인 데이터를 다룰 때 사용
  - `NSCoder` : The NSCoder class and its subclasses take this process a step further by allowing class information to be stored along with the data. The resulting representations are used for archiving and for object distribution.
    (정확한 의미를 알려면 사용해봐야 할 듯 ^^)

* Operating-System Services
  - 대부분의 클래스는 OS의 다양한 특성에 상관없이 동작하도록 디자인되었다.
  - `FileManager` : 파일을 다루는데 일관된 인터페이스를 제공
  - `Thread` : 멀티쓰레드 구현
  - `ProcessInfo` : 앱이 실행될 때 시스템 정보에 접근
See File System Programming Guide for more information.

* URL Loading System
  - NSURL : 앱이 URL을 통해 웹에 접근할 수 있게 하는 클래스와 프로토콜의 집합
  - `NSURLRequest`, `URLResponse` : `URLSession`을 사용해서 송수신을 할 수 있다.
  - `URLProtocol` : 프로토콜 지원
  - `URLAuthenticationChallenge`, `URLCredentialStorage` : 인증, 보안
  - `HTTPCookieStorage` : 쿠키 저장
  - `URLCache` : 캐시 관리

  