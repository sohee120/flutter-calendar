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

  void updateSchedule(DateTime date, int index, String newContent) {
    if (schedules[date] != null && schedules[date]!.contents.length > index) {
      schedules[date]!.contents[index] = newContent;
    }
  }

  void removeSchedule(DateTime date, int idx) {
    if (schedules[date] != null) {
      // 해당 날짜의 일정 목록에서 일정 삭제
      schedules[date]!.contents.removeAt(idx);
    }
  }

  Schedule? getSchedule(DateTime date) {
    return schedules[date];
  }

  String getDayName(int day) {
    return Schedule.getDayName(day);
  }
}