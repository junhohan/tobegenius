# Google Analytics



> 이 글은 구글애널리틱스 무료 온라인 강좌 내용을 공부하며 작성한 글입니다.
> [LINK : 구글애널리틱스 무료 온라인과정](https://analytics.google.com/analytics/academy)



## 1. 디지털 애널리틱스가 중요한 이유



> 구매를 유도한 온라인상의 동작을 추적하고 해당 데이터를 분석하여 신규 및 기존 고객에게 접근하는 방법에 대한 옳은 판단을 내릴 수 있다.



### 사용자 행동 단계

- Acquisition (획득)
  - 인지도 제고
  - 사용자의 관심분야 확보
- Behavior (행동)
  - 사용자가 서비스에 참여하는 시점
- Convension (전환)
  - 서용자가 서비스에 고객으로 전환
  - 거래가 이뤄지는 시점




### 분석 예시

- 지역 매출 데이터를 분석하여 특정 지역의 사용자들이 어느 상품을 많이 구매하는지 파악한 후 그 지역에 추가적인 광고 캠페인에 실행한다.
- 온라인 장바구니에서 어떤 행위를 하는지 파악할 수 있는데, 어느 단계에서 문제가 발생하는 것을 파악도 가능해서 문제를 빠르게 개선할 수 있다.
- 충성도와 참여도가 높은 잠재고객을 파악하고 그런 고객에 맞게 사이트 내의 광고가 UI를 재배치한다.



### 적용가능한 분야

- 모바일앱
- 온라인 판매 사이트
- 비디오 콘솔 게임
- 고객 관계 관리 시스템
- 기타 인터넷에 연결된 플랫폼




## 2. Google Analytics 작동 방식 



> Google Analytics는 데이터를 수집하여 유용한 보고서 형태로 컴파일하는 플랫폼이다



### 분석 동작 방식

- 구글 계정 생성
- 분석하려는 페이지(사실상 모든 페이지)에 자바스크립트 추척 코드 삽입
- 사용자가 해당 페이지에 진입할 때 추적 코드가 해당 페이지와 상호작용한 방법에 대한 정보를 수집 (익명으로 수집)
  - 수집된 정보를 이용하면 간단한 예로 "A상품 페이지"와 "B상품 페이지"를 방문한 사용자 수를 비교할 수 있음
  - 액세스에 사용된 언어, Device, OS, Web Browsers 정보도 수집
  - 해당 페이지로 이동하는 과정을 알 수 있는 Traffic source도 수집
    - Traffic source : 검색엔진, 클릭한 광고, 이메일 마케팅 캠페인 등



- 세션

  - 페이지가 로드될 때마다 추적 코드는 사용자 활동에 대한 정보를 수집/전송하는데, GA에서는 이를 "세션"이라고 하는 특정 기간으로 그룹핑한다.
  - 세션은 사용자가 추적코드가 포함된 페이지에 진입할 때 시작된다.
  - 사용자가 30분 동안 아무런 활동을 하지 않으면 세션이 종료된다.
  - 세션 종료 후, 다시 페이지로 진입하면 새로운 세션이 시작된다.

  ​

- 추적코드가 수집한 데이터는 패키지로 묶어서 GA로 전송한 후, 이를 분석한다.

- 데이터가 처리되는 방식은 관리자가 설정할 수 있다.

  - 사내에서 발생한 트래픽은 필터링하여 제외
  - 주요한 국가 또는 지역 데이터만 포함되도록 설정
  - 세션 시간 설정 (디폴트 30분)

- 한 번 저장된 GA 데이터를 변경이 불가하다.

  - 설정 시, 정말 필요없는 데이터만 필터링해야 한다.

- 데이터에 대한 분석이 끝나면 GA는 보고서를 작성하여 화면에 표시해준다

  ​




## 3. Google Analytics 설정



### Google Analytics 구조

![](https://github.com/junhohan/image4doc/blob/master/ga/ga_001.png?raw=true)



- 모든 GA 계정은 조직 하위로 그룹화할 수 있다. 즉, 여러 GA계정을 한 그룹으로 관리할 수 있다.
  - 작은 조직의 경우 1개의 계정으로 관리하지만, 대기업, 대형 대행사는 여러 계정을 갖는다.

- 계정이 생성되면 자동으로 속성(Property)가 만들어지고 속성 내에 View가 만들어진다. 

- 각각의 GA계정에는 1개 이상의 속성이 위치하고 각각의 속성에는 1개 이상의 뷰가 위치하게 된다.

- 각각의 속성은 추적코드에 기입하는 고유한 추적ID를 사용하여 다른 속성에 영향받지 않고 데이터를 수집할 수 있다.

  - 복수 개의 속성을 이용하면 다수의 웹사이트, 모바일앱, 서비스지역, 브랜드 또는 비지니스와 연결된 또 다른 서비스에서 데이터를 독립적으로 수집할 수 있다.

- 뷰는 구성 설정에서 "필터"라는 기능을 사용하여 각 뷰에 포함할 데이터를 결정할 수 있다.

  ​

- 쉬운 예

  - ABC 쇼핑몰 사이트를 위한 계정을 하나 만들고, 웹사이트만 분석할 속성을 만든 후, View 필터를 이용해서 전체데이터, 서울, 뉴욕 등등에 대한 분석 결과를 볼 수 있는 각각의 View를 만든다.

  ![](https://github.com/junhohan/image4doc/blob/master/ga/ga_002.png?raw=true)

  ​





### 설정

- 데이터 수집 방법
- 데이터에 액세스 할 수 있는 사용자 관리
- 사용자 관리에 대한 방법 결정
  - 비지니스 별로 GA 계정을 만드는 것을 권장
- View Level의 목표 설정
  - 특정 페이지(URI)에 도달한 횟수 (가입완료, 구매완료 등)
  - 버튼 클릭 횟수 (특정 행위 완료 등)




### Views

- 새로운 View가 생성되면 생성 시점 이전의 데이터는 포함하지 않는다.
- View를 삭제하면 관리자가 제한된 시간 내에 복구할 수 있다.
  - 제한된 시간이 지나면 완전히 삭제된다.




### 필터

- 필터를 생성하면 다른 뷰에서도 재사용할 수 있다.

- 하나의 뷰에 여러 개의 필터를 적용할 수 있는데 추가한 순서대로 적용된다.

  - 때문에 필터 간 적용 순서를 유의해야 한다.

    ​

    ​

    ​

## 4. 보고서





### 획득(Acquisition)



> 획득보고서를 이용하면 여러 마케팅 채널(페이스북, 구글광고, 모바일광고 등)의 실적을 비교할 수 있다. 실적이 좋은 채널을 파악할 수 있으므로 마케팅 전략을 세우고 집중할 수 있다.



- 트래픽 소스
  - 사용자가 사이트를 방문하면 GA 추적코드는 사용자의 유입경로에 대한 여러 속성을 자동으로 인식하고 수집한다. 
  - 트래픽 매체(Medium)
    - 사용자를 사이트로 보내는 시스템
    - 자연 (Organic)
      - Google, Naver, Daum 등, 검색을 통해 유입된 트래픽
      - 소스 : 검색엔진 이름
    - CPC
      - Google 애드워즈 광고 등의 유료 검색 캠페인을 통해 유입된 트래픽
    - 추천(Referrals)
      - 검색 엔진이 아닌 타사이트에서 클릭을 통해 유입된 트래픽
      - 소스 : 진입 이전의 사이트 URL
    - 이메일
      - 이메일 마케팅 캠페인을 통해 유입된 트래픽
    - 없음(None) 또는 직접(Direct)
      - 브라우저에 URL을 직접 입력하여 유입된 트래픽
  - 소스(Source)
  - 마케팅 캠페인 이름(Campaign)




## * Google Tag Manager



### Event Tracking

[출처 : Event tracking with Google Tag Manager](https://support.google.com/analytics/answer/6164470?hl=en)



>  이벤트 트래킹은 사용자의 행동을 이해하는 가장 좋은 방법이다. 버튼을 몇 번 눌렀는지, 폼이 얼마나 전송되었는지, 문서가 얼마나 다운로드되었는지를 파악할 수 있기 때문이다.
>
> 이벤트 트래킹을 구현하는 방법은 두 가지가 있는데, 하나는 `Data Layer Event Code`를 작성하는 것과 다른 하나는 `Auto-Event Tracking`을 이용하는 것이다.



- Auto-Event Tracking

Google Tag Manager(이하 GTM)의 Auto-Event Tracking을 이용하면 사용자의 액션을 쉽게 포착할 수 있다. `ga('send', 'event')`와 같은 코드를 작성할 필요 없이 GTM 인터페이스 안에서 직접 태그를 생성하고 GTM UI에서 빌드한 변수(사전정의된 변수 또는 커스텀 변수)에 기초하여 이벤트가 발생한 사실을 전송할 수 있다. 



한 가지 주의해야할 점은 Auto-Event Tracking이 웹사이트가 변경될 때 문제점이 발생할 수 있다는 약점이 있다. 때문에 잘 변경하지 않는 HTML 요소의 식별자(ID, Class name, URL 등)를 측정할 때 사용할 것을 권장한다.



- Data Layer Event Code

식별자가 없거나, GTM으로 트래킹할 수 없는 경우(ex. Flash 상에서의 클릭)에는 `Data Layer Event Code`를 이용한다.



##### Auto-Event Tracking으로 Button Click 이벤트 수집하기

> 시나리오 : 사용자 가입 횟수를 수집하기 위해, 가입완료 버튼에 대한 이벤트가 트리거될 수 있도록 GTM 페이지에서 설정을 하고, GA 페이지에서 "전환 > 목표"를 설정하여 조회할 수 있도록 만든다.

- Step 1 - GTM 변수설정

  tagmanager.google.com에 접속해서 기본제공(Built-In) 변수 설정을 확인한다.

  - 왼쪽 메뉴 > 변수(Variables) > 구성(Configure)
  -  `Click ID` 체크

  ![](https://github.com/junhohan/image4doc/blob/master/ga/ga_003.png?raw=true)

  ​

- Step 2 - GTM 트리거 설정

  이벤트가 트리거(발생)하는 조건을 설정한다. 여기서는 특정 ID를 갖는 요소가 클릭될 때 이벤트를 트리거하라고 설정한다.

  ```html
  <button id="btn_signup_normal">가입완료</button>
  ```

  *  왼쪽 메뉴 > 트리거(Triggers) > 새로 만들기(NEW)
  * Trigger Type > `Click -All Elements`
  * This trigger fires on > `Some Clicks`

  ![](https://github.com/junhohan/image4doc/blob/master/ga/ga_004.png?raw=true)

  - Click ID > equal > `btn_signup_normal`



- Step 3 - GTM 태그 설정

  Step 2에서 생성한 트리거는 ID가 `btn_signup_normal`을 갖는 Button을 클릭할 때, 이벤트가 발생하라는 하나의 정의다. 이제 이 트리거를 연결하는 태그를 만든다. 여기서 만든 태그의 하위 정보가 GA서버로 수집이 된다.

  - 왼쪽 메뉴 > 태그 > 새로 만들기
  - 태그에는 Track Type, Category, Action, Label, Value, Tracking ID 등을 포함한다.
    - Track Type > `Event`
    - Category > `Click`
    - Action > `signup_normal`
    - Label > `{{Click ID}}` (이렇게 하면 수집될 때 실제 ID로 대체된다.)
    - Tracking ID > UA-xxxxxxxxx-x (HTML 헤더에 입력했던 ID)

  ![](https://github.com/junhohan/image4doc/blob/master/ga/ga_005.png?raw=true)

  > 주의 : 변경한 내용이 반영되게 하려면 반드시, 퍼블리시(Submit)까지 완료를 해야한다. Submit 버튼은 오른쪽 상단에 위치해 있다. 사전에 테스트를 해보려면 Submit 왼쪽에 있는 PREVIEW 버튼 사용하면 된다. (Google Chrome Tag Assistance 설치 필요)

  ​

- Step 4 - GA 목표 설정

  이제 Step 3에서 생성한 태그를 선별해서 보여줄 목표 설정을 한다.

  - GA페이지 > View > 목표 > 새 목표
    - 목표 설정 > 템플릿 > 계정만들기
    - 목표 설명 > 이름: `회원가입(일반)` > 목표 유형: `이벤트`
    - 목표 세부정보
      - Category > Same > `Click`
      - Action > Same > `signup_normal`
      - Label > `btn_signup_normal`
  - `저장`후에 (경험상) 5~10분 정도 후에 GA 뷰에 확인할 수 있다.

  ​

  > 주의 : 모든 설정을 끝내고, 실제 이벤트를 발생시킨 후에 GA 화면(뷰)에 반영되기까지 (체감상) 5~10분의 시간이 소요된다. 심지어 데이터가 반영되었다가도 새로고침 후에 다시 사라지기도 한다. (분산된 DB에 모두 반영해야 하는 것으로 보임) 처음에 잘못 설정된 것으로 오해해서 꽤 오랜 시간 삽질을 했는데, 무조건 'GTM에서 설정한 TAG 정보'와 '이벤트가 트리커 될 때의 정보'가 일치한다면 커피 한 잔 마시고 확인하면 된다!

  ​

  ![](https://github.com/junhohan/image4doc/blob/master/ga/ga_006.png?raw=true)



- 참고 : [URL을 이용한 Event Tracking](https://support.google.com/analytics/answer/6164470?hl=en)



# * Search Console

> Google 검색에서 사용자가 어떤 방식으로 내 사이트를 찾았는지 분석할 수 있다.



- GA > 관리 > 속성메뉴 > 모든 제품 > `Search Console 연결` > 
- `추가` > `Search Console에 사이트 추가` > 연결할 URL을 입력 > 확인
- 잘 안되는 경우, 로그인한 계정의 GA 권한을 확인해야 한다. 
  - 로그인한 구글 계정에 Google Tag Manager의 '관리' 권한이 부여되어 있어야 한다.)



[더 봐야할 내용 - Enhanced Ecommerce UA](https://developers.google.com/tag-manager/enhanced-ecommerce)





