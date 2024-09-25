### 09.24
- DateTime 관련 메소드 주석 달기
- 일정 추가 기능	
    - 일정 모델: DateTime타입의 date 속성과 List<String> 타입의 contents 속성 존재
    - 일정 컨트롤러: Map<DateTime, Schedule> 타입의 schedules 프로퍼티로 데이터 관리, 일정 데이터 추가/조회 함수
    - CalendarScreen에서 각 날짜별 container 누를 시,
     일정을 보여주는 dialog 구현: 일정 추가 버튼과 확인 버튼
     일정 추가 -> 일정을 추가할 수 있는 bottomModalSheet 구현: 저장 버튼과 취소 버튼
- 캘린더에서 현재 날짜 구분되지 않는 문제 해결
`day == DateTime.now()`로 현재 날짜와 같은지 판단하려했으나 이 경우엔 시간까지 동일해야함.
```dart
day.year == DateTime.now().year &&
day.month == DateTime.now().month &&
day.day == DateTime.now().day
```
년, 월, 일만 비교

### 09.25
- [X] 캘린더 뷰에서 일정 추가 모달, 일정 조회 다이얼로그 분리
- [X] 일정 수정, 삭제 기능
- [ ] 디테일 잡기	
    - 일정의 개수가 많아질때, 달력 칸 넘어가는 문제 해결	
    - 일정 유무에 따라 일정등록/추가 버튼 라벨을 구분지었는데 동작하지 않는 문제 해결

일정 수정/삭제 기능 구현하는 과정에서 수정, 삭제 완료하고 모달을 닫고 나오는 캘린더 화면에서 상태가 반영되지 않는 문제가 발생했습니다.
async/await를 써서 수정/삭제가 완료되면 setState를 통해 화면을 갱신하고자 하였으나 해결되지 않았습니다.
상태 관리에 대해 좀 더 학습하고 다시 해보겠습니다.
