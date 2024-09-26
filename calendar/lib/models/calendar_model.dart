class CalendarModel {
  // 해당 월의 날짜 리스트를 가져오는 함수
  static List<DateTime> getDaysInMonth(DateTime date) {
    // DateTime(year, month, day) 형식으로 사용되는 이 생성자는 특정 연도, 월, 일자를 기준으로 DateTime 객체를 생성. 주어진 날짜에 해당하는 객체를 반환
    final firstDayOfMonth = DateTime(date.year, date.month, 1); // 주어진 날짜가 속한 월의 첫 번째 날짜
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0); //DateTime 생성자에서 day 파라미터에 0을 넣으면, 해당 월의 전 달의 마지막 날 나타냄

    // subtract() 메소드는 현재 DateTime 객체에서 지정한 Duration만큼 시간을 뺀 새로운 DateTime 객체를 반환 (주간이 시작되는 날짜로 이동시키는 역할)
    // add() 메소드는 현재 DateTime 객체에 지정한 Duration만큼 시간을 더한 새로운 DateTime 객체를 반환(해당 주의 마지막 날(토요일)까지의 날짜를 맞추기 위해)
    // weekday 메소드는 DateTime 객체에서 요일을 숫자로 반환하는 메소드. 반환되는 값은 1부터 7까지의 정수로, 각각 월요일부터 일요일까지

    """ ex 2024년 9월: DateTime(2024, 9, 1)
    firstDayOfMonth = 2024.09.01
    firstDayOfMonth.weekday = 7(일요일)
    firstDayOfMonth.weekday % 7 = 0
    firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7)) = 2024.09.01 - 0
    
    lastDayOfMonth = DateTime(2024, 9, 30)
    lastDayOfMonth.weekday = 1 (월요일)
    6 - lastDayOfMonth.weekday = 5
    lastDayOfMonth.add(Duration(days: 6 - lastDayOfMonth.weekday)); = 2024 09 30 의 5일뒤 : DateTime(2024, 10, 5)
    
    1. 해당 월의 첫 번째 날짜를 계산.
    2. 해당 월의 마지막 날짜를 계산.
    3. 첫 번째 날짜가 속한 주의 일요일로 이동.
    4. 마지막 날짜가 속한 주의 토요일로 이동.
    5. 첫 번째 일요일부터 마지막 토요일까지의 날짜 리스트를 생성해 반환.
    """;

    final firstDayOfCalendar = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    final lastDayOfCalendar = lastDayOfMonth.add(Duration(days: 6 - lastDayOfMonth.weekday));


    return List.generate(
      lastDayOfCalendar.difference(firstDayOfCalendar).inDays + 1, // 달력의 마지막 날짜와 첫번째 날짜의 차이 + 1 (ex: 2024.09.01 - 2024.10.05: 35)
          // index에 따라 첫 번째 날짜(firstDayOfCalendar)에서 하루씩 더해가며 새로운 DateTime 객체를 생성
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
