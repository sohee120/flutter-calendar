import 'package:calendar/screens/schedule_dialog.dart';
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
    _calendarController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 높이
    double height = MediaQuery.of(context).size.height;
    // 화면의 너비
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () async {
              await _calendarController.pickDate(context); // 날짜 선택 기능은 컨트롤러에서 처리
              setState(() {});
            },
            child: Row(
              children: [
                Text(
                    "${_calendarController.selectedDate.year}년 ${_calendarController.getMonthName()}월"),
                Icon(Icons.arrow_drop_down)
              ],
            )),
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
                    child: Text(day,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }).toList(),
          ),
          // 날짜 그리드뷰
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero, // 패딩을 0으로 설정하여 여백 제거
              itemCount: _calendarController.daysInMonth.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio:
                    (width / 7) / (height*0.7/5),
              ),
              itemBuilder: (context, index) {
                final day = _calendarController.daysInMonth[index];
                bool isCurrentMonth =
                    day.month == _calendarController.selectedDate.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _calendarController.setSelectedDate(day);
                      showScheduleDialog(context, day, _scheduleController);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(2.0), // 마진을 최소화하여 화면을 더 채우도록 함
                    decoration: BoxDecoration(
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
                              children: <Widget>[
                                if (_scheduleController
                                        .schedules[day]?.contents.isNotEmpty ??
                                    false)
                                  ..._scheduleController
                                      .schedules[day]!.contents
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
                    ),
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
