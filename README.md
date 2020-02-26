# neis-api

[나이스](https://www.neis.go.kr/) 학생서비스 페이지를 파싱하여 JSON API로 제공하는 서비스입니다.

## 기본 URL

https://api.chemistryx.me/neis

## 급식 불러오기

### 요청

`GET /meal/{schoolCode}/{schoolStage}/{year}/{month}`

| 매개변수    | 설명                                     |
| :---------- | :--------------------------------------- |
| schoolCode  | [학교 코드](#학교-코드)(10자리)          |
| schoolStage | [학교 과정 코드](#학교-과정-코드)(1자리) |
| year        | 조회하고자 하는 연도(4자리)              |
| month       | 조회하고자 하는 달(2자리)                |

### 응답

```json
{
  "status": true,
  "schoolCode": "X000000000",
  "schoolStage": "0",
  "year": "2020",
  "month": "02",
  "menu": [
    {
      "date": 1,
      "breakfast": [],
      "lunch": ["현미밥(고)", "쇠고기감자국(고)", "포크커틀렛(고)", "꼬마새송이버섯볶음", "야채쫄면무침(고)", "배추김치(고)", "된장소스(고)", "키위"],
      "dinner": []
    }
  ]
}
```

## 학사일정 불러오기

### 요청

`GET /schedule/{schoolCode}/{schoolStage}/{year}/{month}`

| 매개변수    | 설명                                     |
| :---------- | :--------------------------------------- |
| schoolCode  | [학교 코드](#학교-코드)(10자리)          |
| schoolStage | [학교 과정 코드](#학교-과정-코드)(1자리) |
| year        | 조회하고자 하는 연도(4자리)              |
| month       | 조회하고자 하는 달(2자리)                |

### 응답

```json
{
  "status": true,
  "schoolCode": "X000000000",
  "schoolStage": "0",
  "year": "2020",
  "month": "02",
  "schedule": [
    {
      "date": 1,
      "content": ["여름방학"]
    }
  ]
}
```

## 설치하기

`참고` [Ruby 2.5](https://www.ruby-lang.org)이상이 설치되어 있어야 합니다.

```
bundle install
```

## 실행하기

```
jets server
```

## 도움말

### 학교 코드

학교 코드는 https://par.goe.go.kr/spr_ccm_cm01_100.do?kraOrgNm={학교이름} 을 통해 나온 `orgCode`값에서 찾을 수 있습니다.

### 학교 과정 코드

학교 과정 코드는 다음과 같습니다.

| 학교     | 학교 과정 코드 |
| :------- | :------------- |
| 고등학교 | 4              |
| 중학교   | 3              |
| 초등학교 | 2              |
