import 'package:flutter/material.dart';
import '../controllers/schedule_controller.dart';

Future<void> showScheduleDetailScreen(BuildContext context, DateTime date, int idx,
    ScheduleController scheduleController) async {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context); // 세부 일정 모달 닫기
                      showEditScheduleModal(context, date, idx, scheduleController); // 일정 수정 모달 열기
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await showDeleteConfirmationDialog(context, date, idx, scheduleController);
                      }
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('${scheduleController.schedules[date]?.contents[idx]}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${date.month}월 ${date.day}일 ${scheduleController.getDayName(date.weekday)}',
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      });
}

Future<void> showDeleteConfirmationDialog(BuildContext context, DateTime date, int idx,
    ScheduleController scheduleController) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("삭제하시겠습니까?"),
        content: Text("이 일정을 삭제하시겠습니까?"),
        actions: <Widget>[
          TextButton(
            child: Text("취소"),
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
          ),
          TextButton(
            child: Text("삭제"),
            onPressed: () {
              scheduleController.removeSchedule(date, idx); // 인덱스 기반 삭제
              Navigator.of(context).pop(); // 다이얼로그 닫기
              Navigator.of(context).pop(); // 모달 닫기
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showEditScheduleModal(BuildContext context, DateTime date, int idx, ScheduleController scheduleController) {
  TextEditingController _textController = TextEditingController(
    text: scheduleController.schedules[date]!.contents[idx],
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets, // 키보드가 올라왔을 때 공간 확보
        child: Container(
          padding: EdgeInsets.all(16),
          height: 250,
          child: Column(
            children: <Widget>[
              Text(
                "${date.year}-${date.month}-${date.day} 일정 수정",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "일정 내용",
                  hintText: "수정할 내용을 입력하세요",
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
                      Navigator.pop(context); // 모달 닫기
                    },
                    child: Text("취소"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        scheduleController.updateSchedule(date, idx, _textController.text); // 일정 수정
                        Navigator.pop(context); // 모달 닫기 // 화면 갱신
                      }
                    },
                    child: Text("저장"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
