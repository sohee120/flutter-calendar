import 'package:flutter/material.dart';
import '../controllers/schedule_controller.dart';

void showAddScheduleModal(BuildContext context, DateTime date, ScheduleController scheduleController) {
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
            SizedBox(height: 10),
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
                      scheduleController.addSchedule(date, _textController.text);
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
