# Mongo Shell

가장 최근에 기록된 2개의 도큐먼트 조회하기  
`current`는 collection 이름  
`natural`값이 1이면 디스크에 적힌 순서대로 정렬, -1은 역순 정렬 (최근 내용을 보려면 -1로 입력)

```BASH
> db.current.find().sort({$natural:-1}).limit(2);
```