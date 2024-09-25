class Schedule {
  final DateTime date;
  List<String> contents;

  Schedule({ required this.date, this.contents = const [] });

  static String getDayName(int day) {
    const days = [
      '월', '화', '수', '목', '금', '토', '일'
    ];
    return days[day - 1];
  }
}