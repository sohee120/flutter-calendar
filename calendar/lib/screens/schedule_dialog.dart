import 'schedule_detail_screen.dart';
import 'package:flutter/material.dart';
import '../controllers/schedule_controller.dart';
import './add_schedule_modal.dart';

Future<void> showScheduleDialog(BuildContext context, DateTime date,
    ScheduleController scheduleController, Function setStateCallback) async {
  showDialog(
      context: context,
      builder: (BuildContext context)  {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: <Widget>[Text('${date.month}월 ${date.day}일')],
          ),
          content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 일정이 있는 경우 일정들 표시
                if (scheduleController.schedules[date]?.contents.isNotEmpty ??
                    false)
                  ...scheduleController.schedules[date]!.contents.asMap().entries.map((entry) =>
                          GestureDetector(onTap: () async {
                            await showScheduleDetailScreen(context, date, entry.key, scheduleController, setStateCallback);
                          }, child: Text('${entry.value}')))
                      .toList()
                else
                  Text("일정이 없습니다."),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showAddScheduleModal(context, date, scheduleController);
                        },
                        child: scheduleController
                                    .schedules[date]?.contents == null
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
            )
        );
      });
}
