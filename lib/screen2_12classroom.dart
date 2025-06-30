import 'package:flutter/material.dart';
import 'package:new_sample001/screen2_notclassroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Widget _classroomTile(String roomName) {
  final docRef = FirebaseFirestore.instance.collection('classrooms12').doc(roomName);
  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    stream: docRef.snapshots(),
    builder: (context, snapshot) {
      final isSelected = (snapshot.data?.data()?['using'] ?? false) as bool;
      return GestureDetector(
        onTap: () async {
          await docRef.set({'using': !isSelected}); // トグル保存
        },
        child: convers_container(roomName, isSelected: isSelected),
      );
    },
  );
}

Widget get_available_12classroom() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _classroomTile('124'),
      // 他の教室も同様に _classroomTile('125') などを追加
    ],
  );
}
