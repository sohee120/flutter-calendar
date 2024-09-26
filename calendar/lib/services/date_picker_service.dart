import 'package:flutter/material.dart';

class DatePickerService {
  static Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
    // Flutter에서 제공하는 기본 날짜 선택기
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}

