# Optimized C++

## std::string

#### Concatenation

- (X)

```c++
std::string result;
char c = 'A';
result = result + c;
```

- (O)
  - += : the mutating concatenating assignment operator
  - 임시 변수를 사용하지 않기 때문에 추가 메모리 할당을 위한 호출이 없어졌고 복사 및 메모리 해제를 할 일도 없어진다.,
  - 때에 따라 위 코드보다 약 13배 소요시간 감소

```C++
std::string result;
char c = 'A';
result += c;
```



## 