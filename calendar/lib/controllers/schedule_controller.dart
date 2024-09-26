import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class ScheduleController {
  // Map<DateTime, Schedule> 형태로 날짜별 일정을 저장, schedules를 통해 일정 데이터를 추가/수정/삭제하는 로직을 제공
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

  void removeSchedule(DateTime date, int index) {
    if (schedules[date] != null) {
      schedules[date]!.contents.removeAt(index);
    }
  }

  Schedule? getSchedule(DateTime date) {
    return schedules[date];
  }

  // 숫자로 표현된 요일(1~7)을 문자열(월, 화, 수, ...)로 변환하여 반환
  String getDayName(int day) {
    return Schedule.getDayName(day);
  }
}