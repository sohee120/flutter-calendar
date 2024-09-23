class CalendarModel {
  // 해당 월의 날짜 리스트를 가져오는 함수
  static List<DateTime> getDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1); // 주어진 날짜가 속한 월의 첫 번째 날짜
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final firstDayOfCalendar = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    final lastDayOfCalendar = lastDayOfMonth.add(Duration(days: 6 - lastDayOfMonth.weekday));

    return List.generate(
      lastDayOfCalendar.difference(firstDayOfCalendar).inDays + 1,
          (index) => DateTime(firstDayOfCalendar.year, firstDayOfCalendar.month, firstDayOfCalendar.day + index),
    );
  }

  // 월 이름을 반환하는 함수
  static String getMonthName(int month) {
    const months = [
      "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"
    ];
    return months[month - 1];
  }
}
