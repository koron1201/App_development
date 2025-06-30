import 'package:flutter/material.dart';
import 'package:new_sample001/screen2_notclassroom.dart';

Widget convers_container(String classroomName, {bool isSelected = false}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isSelected ? Colors.red[50] : Colors.blue[50], // 選択時は薄い赤
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: isSelected ? Colors.red : Colors.blue, width: 2), // 枠線
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          classroomName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.red : Colors.blue, // 選択時は赤文字
          ),
          textAlign: TextAlign.center,
        ),
        if (isSelected)
          Text(
            '使用中',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red, // 赤文字
            ),
          ),
      ],
    ),
  );
}

Widget get_available_12classroom(Function selectClassroom, String? selectedClassroom) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () => selectClassroom('124'),
        child: convers_container('124', isSelected: selectedClassroom == '124'),
      ),
      // 他の教室も同様に追加
    ],
  );
}
