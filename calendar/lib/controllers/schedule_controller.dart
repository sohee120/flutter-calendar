import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class ScheduleController {
  Map<DateTime, Schedule> schedules = {};

  void addSchedule(DateTime date, String content) {
    if (schedules.containsKey(date)) {
      schedules[date]!.contents.add(content);
    } else {
      schedules[date] = Schedule(date: date, contents: [content]);
    }
  }

  Schedule? getSchedule(DateTime date) {
    return schedules[date];
  }
}