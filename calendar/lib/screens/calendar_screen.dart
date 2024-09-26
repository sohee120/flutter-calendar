import 'schedule_dialog.dart';
import 'package:flutter/material.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/schedule_controller.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();
  final ScheduleController _scheduleController = ScheduleController();

  @override
  void initState() {
    super.initState();
    // 선택된 월(현재 날짜가 속해있는 달)에 해당하는 날짜 리스트 (daysInMonth)를 계산
    _calendarController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar - 현재 날짜 표시, 날짜 탭 -> 원하는 날짜가 속한 달력으로 이동, 이전 달로 이동, 다음 달로 이동
      appBar: AppBar(
        title: GestureDetector(
            onTap: () async {
              await _calendarController.pickDate(context); // 날짜 선택 기능은 컨트롤러에서 처리
              setState(() {});
            },
            child: Row(
              children: [
                Text("${_calendarController.selectedDate.year}년 ${_calendarController.getMonthName()}월"),
                Icon(Icons.arrow_drop_down)
              ],
            )
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _calendarController.goToPreviousMonth();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {
                _calendarController.goToNextMonth();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 요일 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['일', '월', '화', '수', '목', '금', '토'].map((day) {
              return Expanded(
                child: Align(
                  alignment: Alignment.topLeft, // 좌측 상단으로 정렬
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                        day,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // 날짜 그리드뷰
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: _calendarController.daysInMonth.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7개의 열 (요일 수)
                childAspectRatio:
                    (width / 7) / (height*0.7/5), // 화면의 너비와 높이를 기준으로 셀 크기 비율 설정
              ),
              itemBuilder: (context, index) {
                // 계산된 날짜 리스트에서 날짜 가져오기
                final day = _calendarController.daysInMonth[index];
                bool isCurrentMonth =
                    day.month == _calendarController.selectedDate.month;

                // 날짜 셀
                return GestureDetector(
                  onTap: () async {
                      _calendarController.setSelectedDate(day);
                      // 날짜를 탭하면 onTap 이벤트가 발생하여 선택한 날짜가 업데이트되고 일정 다이얼로그 띄움
                      await showScheduleDialog(context, day, _scheduleController, () {
                        setState(() {});
                      });
                  },
                  // Container 위젯을 사용해 각 날짜 셀을 그림
                  child: Container(
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      // 현재 날짜를 구분하기 위해 투명한 파란색으로 배경 채움
                      // 이전 달 또는 다음 달에 속하는 날짜는 흐린 회색으로 표시
                      color: day.year == DateTime.now().year &&
                          day.month == DateTime.now().month &&
                          day.day == DateTime.now().day
                          ? Colors.blue.withOpacity(0.5)
                          : isCurrentMonth
                              ? Colors.white
                              : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: day == _calendarController.selectedDate
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    // 셀 안에 일정들 표시
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft, // 좌측 상단으로 정렬
                          child: Padding(
                            padding: EdgeInsets.all(4.0), // 좌측 상단에 여유 공간 추가
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color:
                                    isCurrentMonth ? Colors.black : Colors.grey,
                                fontWeight: day == _calendarController.selectedDate
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft, // 좌측 상단으로 정렬
                          child: Padding(
                            padding: EdgeInsets.all(2.0), // 좌측 상단에 여유 공간 추가
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (_scheduleController
                                        .schedules[day]?.contents.isNotEmpty ??
                                    false)
                                  ..._scheduleController
                                      .schedules[day]!.contents
                                  .take(3)
                                      .map((item) => Text(
                                            item,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                      .toList(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ), // 일정 column
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
