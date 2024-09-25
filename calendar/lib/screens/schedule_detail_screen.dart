import 'package:flutter/material.dart';
import '../controllers/schedule_controller.dart';

void showScheduleDetailScreen(BuildContext context, DateTime date, int idx,
    ScheduleController scheduleController) {
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
                  IconButton(icon: Icon(Icons.clear), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
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
