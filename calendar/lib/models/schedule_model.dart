class Schedule {
  // 일정 데이터를 관리하는 모델로, 각 날짜와 해당 날짜의 일정을 리스트로 관리
  final DateTime date;
  List<String> contents;

  Schedule({ required this.date, this.contents = const [] });

  // 요일을 숫자로 받아 문자열로 변환해 반환
  static String getDayName(int day) {
    const days = [
      '월', '화', '수', '목', '금', '토', '일'
    ];
    return days[day - 1];
  }
}