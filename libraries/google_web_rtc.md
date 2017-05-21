# WebRTC란?

- Web Real-Time Communication의 약자  
- P2P 통신 기반의 실시간 통신을 할 수 있도록 통신 프로토콜과 어플리케이션 인터페이스를 구현해 놓은 집합을 의미함  
- WebRTC를 이용하면 웹브라우저가 서버의 리소스를 요청하는 것 뿐만아니라 다른 사용자의 브라우저와 실시간으로 정보를 주고 받을 수 있도록 구현할 수 있음  
- 표준화는 W3C(World Wide Web Consortium)와 IETF(Internet Engineering Task Force)에서 함  

- Reference Code는 BSD license로 배포되고 있음

# vs WebSocket
WebRTC는 비디오, 오디오 등의 고성능, 고품질 통신을 목적으로 고안되었다. WebSocket으로도 스트리밍 서비스를 구현할 수 있다. 하지만, 애초부터 서버와 클라이언트간 통신(bi-directional communication)을 위해 디자인되었기 때문에 높은 품질의 스트리밍 서비스를 준비한다면 WebSocket보다 WebRTC를 고려하는 것이 좋다.

* WebRTC Google I/O : [영상보기](https://www.youtube.com/watch?v=p2HzZkd2A40)


