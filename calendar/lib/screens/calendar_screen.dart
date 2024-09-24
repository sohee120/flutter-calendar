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

  void showScheduleDialog(DateTime date) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: <Widget>[Text('${date.month}월 ${date.day}일')],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (_scheduleController.schedules[date]?.contents.isNotEmpty ??
                    false)
                  ..._scheduleController.schedules[date]!.contents
                      .map((item) => Text(item))
                      .toList()
                else
                  Text("일정이 없습니다."),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showAddScheduleModal(date);
                        },
                        child: _scheduleController
                                    .schedules[date]?.contents.isEmpty ==
                                true
                            ? Text('일정 등록')
                            : Text('일정 추가')),
                    //
                    SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인')),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void showAddScheduleModal(DateTime date) {
    TextEditingController _textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 450,
          padding: EdgeInsets.all(16), // 적절한 패딩 추가
          child: Column(
            children: <Widget>[
              Text(
                "${date.year}-${date.month}-${date.day} 일정 추가",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10), // 텍스트 필드와 버튼 사이의 공간
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "일정 내용",
                  hintText: "일정 내용을 입력하세요",
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 닫기 버튼
                    },
                    child: Text("취소"),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        setState(() {
                          _scheduleController.addSchedule(
                              date, _textController.text);
                        });
                        Navigator.pop(context); // 저장 후 닫기
                        Navigator.pop(context); // 다이얼로그 닫기
                      }
                    },
                    child: Text("저장"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
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
                      showScheduleDialog(day);
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
