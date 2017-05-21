
# Google Elevation API

API 예제  

```
  https://maps.googleapis.com/maps/api/elevation/json?locations=37.551879,126.915415&key=[YOUR_API_KEY]
```

- YOUR API KEY : [만들기](https://developers.google.com/maps/documentation/elevation/start#get-a-key)


결과  

```JSON
  {
	results: [
	{
	  elevation: 26.14416694641113,
	  location: {
	    lat: 37.551879,
	    lng: 126.915415
	  },
	  resolution: 152.7032318115234
	 }
	],
	status: "OK"
  }
```

- elevation : 해당 위치의 높이, 26.144 meter
- resolution : 해상도, 152.703 meter

한 번에 여러 개의 위치(Path)를 입력해서 고도 변화량을 얻을 수 있다.

```
  https://maps.googleapis.com/maps/api/elevation/json?path=36.578581,-118.291994|36.23998,-116.83171&samples=3&key=YOUR_API_KEY
```

개발자 가이드 : [바로가기](https://developers.google.com/maps/documentation/elevation/intro#ElevationResponses)



