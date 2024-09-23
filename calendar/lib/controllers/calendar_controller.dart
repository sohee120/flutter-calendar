import 'package:flutter/material.dart';
import '../models/calendar_model.dart';
import '../services/date_picker_service.dart'; // 날짜 선택 서비스 임포트

class CalendarController {
  DateTime selectedDate = DateTime.now();
  List<DateTime> daysInMonth = [];

  // 초기화 메서드
  void initialize() {
    daysInMonth = CalendarModel.getDaysInMonth(selectedDate);
  }

  // 이전 달로 이동
  void goToPreviousMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    daysInMonth = CalendarModel.getDaysInMonth(selectedDate);
  }

  // 다음 달로 이동
  void goToNextMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    daysInMonth = CalendarModel.getDaysInMonth(selectedDate);
  }

  // 월 이름 가져오기
  String getMonthName() {
    return CalendarModel.getMonthName(selectedDate.month);
  }

  // 선택된 날짜 설정
  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }

  // 날짜 선택 로직을 DatePickerService로 위임
  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await DatePickerService.pickDate(context, selectedDate);
    if (pickedDate != null && pickedDate != selectedDate) {
      setSelectedDate(pickedDate);
      initialize();
    }
  }
}
