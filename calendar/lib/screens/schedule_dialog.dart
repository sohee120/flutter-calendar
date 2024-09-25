import 'package:flutter/material.dart';
import '../controllers/schedule_controller.dart';
import './add_schedule_modal.dart';

void showScheduleDialog(BuildContext context, DateTime date, ScheduleController scheduleController) {
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
              if (scheduleController.schedules[date]?.contents.isNotEmpty ??
                  false)
                ...scheduleController.schedules[date]!.contents
                    .map((item) => Text(item))
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
      }
    );
}
