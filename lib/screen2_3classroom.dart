import 'package:flutter/material.dart';
import 'package:new_sample001/screen2_notclassroom.dart';

Widget convers_container(String classroomName, {bool isSelected = false}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isSelected ? Colors.red[50] : Colors.blue[50], // 背景色を変更
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: isSelected ? Colors.red : Colors.blue, width: 2), // 枠線の色を変更
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          classroomName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.red : Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
        if (isSelected) // 使用中の文字を表示
          Text(
            '使用中',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
      ],
    ),
  );
}

Widget get_available_3classroom() {
  final nowTime = DateTime.now(); // 現在の時間を取得
  final hour = nowTime.hour;
  final minute = nowTime.minute;
  final weekday = nowTime.weekday;
  final month = nowTime.month;

  //月曜1限


  // 時間帯に応じた空き教室の情報を設定
  //ここから前期(4=7月)
  if (month >= 4 && 7 >= month) {
    //前期の月曜日
    if (weekday == DateTime.monday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      }
      //2限
       else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3130'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) || (hour == 13) || (hour == 14) || (hour == 15 && minute < 20)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //4限
      else if ((hour == 15 && minute >= 20) || (hour == 16) || (hour == 17 && minute < 10)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) || (hour == 18) || (hour == 19 && minute < 0)) {
        return display_allclassroom('3');
      } 
      //7時以降の
      else {
        return display_allclassroom('3');
      }
    }
    //前期の火曜日
    else if (weekday == DateTime.tuesday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3220'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) || (hour == 13) || (hour == 14) || (hour == 15 && minute < 20)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //4限
      else if ((hour == 15 && minute >= 20) || (hour == 16) || (hour == 17 && minute < 10)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3230'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) || (hour == 18) || (hour == 19 && minute < 0)) {
        return display_allclassroom('3');
      } else {
        return display_allclassroom('3');
      }
    }
    //前期の水曜日
    else if (weekday == DateTime.wednesday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
              ],
            )
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
  
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3240'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) || (hour == 13) || (hour == 14) || (hour == 15 && minute < 20)) {
        return display_allclassroom('3');
      } 
      //4限
      else if ((hour == 15 && minute >= 20) || (hour == 16) || (hour == 17 && minute < 10)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3130'),
              SizedBox(height: 20),
              convers_container('3140'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) || (hour == 18) || (hour == 19 && minute < 0)) {
        return display_allclassroom('3');
      } else {
        return display_allclassroom('3');
      }
    }
    //前期の木曜日
    else if (weekday == DateTime.thursday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3210'),
                SizedBox(height: 20),
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) || (hour == 13) || (hour == 14) || (hour == 15 && minute < 20)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
                SizedBox(height: 20),
                convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
              ],
            )
          ],
        );
      } 
      //4限
      else if ((hour == 15 && minute >= 20) || (hour == 16) || (hour == 17 && minute < 10)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
                SizedBox(height: 20),
                convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) || (hour == 18) || (hour == 19 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
                SizedBox(height: 20),
                convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } else {
        return display_allclassroom('3');
      }
    }
    //前期の金曜日
    else if (weekday == DateTime.friday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3130'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3230'),
                SizedBox(height: 20),
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3250'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) || (hour == 13) || (hour == 14) || (hour == 15 && minute < 20)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3130'),
                SizedBox(height: 20),
                convers_container('3140'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3220'),
                SizedBox(height: 20),
                convers_container('3240'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
                SizedBox(height: 20),
                convers_container('3350'),
              ],
            )
          ],
        );
      } 
      //4限
      else if ((hour == 15 && minute >= 20) || (hour == 16) || (hour == 17 && minute < 10)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              convers_container('3120'),
              SizedBox(height: 20),
              convers_container('3140'),
              SizedBox(height: 20),
              convers_container('3150'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3120'),
                SizedBox(height: 20),
                convers_container('3240'),
                SizedBox(height: 20),
                convers_container('3320'),
                SizedBox(height: 20),
                convers_container('3330'),
                SizedBox(height: 20),
                convers_container('3340'),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                convers_container('3250'),
              ],
            )
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) || (hour == 18) || (hour == 19 && minute < 0)) {
        return display_allclassroom('3');
      } else {
        return display_allclassroom('3');
      }
    }
    //土日
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '土日のため、授業中の教室はありません',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
  //ここから後期
  else if (month >= 9 || 1 == month) {
    //後期の月曜日
    if (weekday == DateTime.monday) {
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在、授業中の教室はありません',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
    //後期の火曜日
    if (weekday == DateTime.tuesday) {
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在、授業中の教室はありません',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
    //後期の水曜日
    if (weekday == DateTime.wednesday) {
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在、授業中の教室はありません',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
    //後期の木曜日
    if (weekday == DateTime.thursday) {
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在、授業中の教室はありません',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
    //後期の金曜日
    if (weekday == DateTime.friday) {
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('1号館11教室'),
            SizedBox(height: 20),
            convers_container('1号館13教室'),
            SizedBox(height: 20),
            convers_container('2号館11教室'),
            SizedBox(height: 20),
            convers_container('2号館13教室'),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在、授業中の教室はありません',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
    }
    //土日
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '土日のため、授業中の教室はありません',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  //return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             '土日のため、授業中の教室はありません',
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.red,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       );

  //長期休み
  else {
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '現在、長期休み中',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 244, 54, 206),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
  
}
