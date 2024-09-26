import 'package:flutter/material.dart';
import '../models/calendar_model.dart';
import '../services/date_picker_service.dart'; // 날짜 선택 서비스 임포트

class CalendarController {
  DateTime selectedDate = DateTime.now();
  // 현재 날짜가 포함되어 있는 달의 첫 번째 주의 일요일부터 마지막 주의 토요일까지의 모든 날짜 리스트
  List<DateTime> daysInMonth = [];

  // 초기화 메서드
  void initialize() {
    daysInMonth = CalendarModel.getDaysInMonth(selectedDate);
    // 실행되면 달력에 표시할 날짜들을 생성
    // 달력에서 첫 번째 주의 일요일부터 마지막 주의 토요일까지의 모든 날짜를 포함
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
    // DatePickerService의 showDatePicker를 호출
    // await를 사용하여 사용자가 날짜를 선택할 때까지 기다렸다가 이후에 다음 동작 실행
    DateTime? pickedDate = await DatePickerService.pickDate(context, selectedDate);
    // 선택된 날짜가 유효한지 확인: null이 아니고 현재 선택된 날짜와 다르면 새로운 날짜로 업데이트
    if (pickedDate != null && pickedDate != selectedDate) {
      setSelectedDate(pickedDate);
      initialize();
    }
  }
}
