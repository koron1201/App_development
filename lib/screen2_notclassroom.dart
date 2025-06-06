import 'package:flutter/material.dart';

Widget display_allclassroom(String num){
  return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 220),
            Text(
              '現在、'+num+'号館で授業中の教室は\nありません。',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 220),
          ],
        );
}

Widget display_notclassroom(String num){
  return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 220),
            Text(
              '現在、'+num+'使用可能な教室は\nありません。',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 220),
          ],
        );
}

Widget table_classroom(Widget colum_1,Widget colum_2,Widget colum_3){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      colum_1,
      const SizedBox(width: 40),
      colum_2,
      const SizedBox(width: 40),
      colum_3,
    ],
  );
}
//教室が使用可能なときに使用
Widget not_use_class_container(String classroomName) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue[50], // 背景色を追加
      borderRadius: BorderRadius.circular(10), // 角を丸くする
      border: Border.all(color: Colors.blue, width: 2), // 枠線を追加
    ),
    child: Text(
      classroomName,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
//教室が使用不可の時に使用
Widget use_class_container(){
  return Container(
    height: 60,
    width: 75,
    padding: EdgeInsets.all(16),
    color: Colors.white,
  );
}