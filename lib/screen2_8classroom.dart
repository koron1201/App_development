import 'package:flutter/material.dart';
import 'package:new_sample001/screen2_notclassroom.dart';

Widget convers_container(String classroomName) {
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

Widget get_available_8classroom() {
  final nowTime = DateTime.now(); // 現在の時間を取得
  final hour = nowTime.hour;
  final minute = nowTime.minute;
  final weekday = nowTime.weekday;
  final month = nowTime.month;

  // 時間帯に応じた空き教室の情報を設定
  //ここから前期
  if (month >= 4 && 7 >= month) {
    //前期の月曜日
    if (weekday == DateTime.monday) {
      //1限
      if ((hour == 9 && minute >= 20) || (hour == 10) || (hour == 11 && minute < 0)) {
        return display_notclassroom('8');
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return display_notclassroom('8');
      } 
      //3限
      else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return display_notclassroom('8');
      } 
      //4限
      else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return display_notclassroom('8');
      }
      //5限
      else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return display_allclassroom('8');
      }
      else {
        return display_allclassroom('8');
      }
    }
    //前期の火曜日
    else if (weekday == DateTime.tuesday) {
      //1限
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8203'),
            
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8203'),
            
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return display_notclassroom('8');
      } 
      //4限
      else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return display_allclassroom('8');
      }
      //5限
      else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return display_allclassroom('8');
      } 
      else {
        return display_allclassroom('8');
      }
    }
    //前期の水曜日
    else if (weekday == DateTime.wednesday) {
      //1限
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return display_notclassroom('8');
      } 
      //3限
      else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return display_allclassroom('8');
      }
      //4限
      else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return display_allclassroom('8');
      }
      //5限
      else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return display_allclassroom('8');
      } 
      else {
        return display_allclassroom('8');
      }
    }
    //前期の木曜日
    else if (weekday == DateTime.thursday) {
      //1限
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            
          ],
        );
      }
      //2限 
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return display_notclassroom('8');
      } 
      //3限
      else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return display_allclassroom('8');
      }
      //4限
      else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            
          ],
        );
      } 
      //5限
      else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return display_allclassroom('8');
      } 
      else {
        return display_allclassroom('8');
      }
    }
    //前期の金曜日
    else if (weekday == DateTime.friday) {
      //1限
      if ((hour == 9 && minute >= 20) ||
          (hour == 10) ||
          (hour == 11 && minute < 0)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8203'),
            
          ],
        );
      } 
      //2限
      else if ((hour == 11 && minute >= 0) || (hour == 12 && minute < 50)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            SizedBox(height: 20),
            
          ],
        );
      } 
      //3限
      else if ((hour == 12 && minute >= 50) ||
          (hour == 13) ||
          (hour == 14) ||
          (hour == 15 && minute < 20)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            
          ],
        );
      } 
    //4限
      else if ((hour == 15 && minute >= 20) ||
          (hour == 16) ||
          (hour == 17 && minute < 10)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            convers_container('8201'),
            
          ],
        );
      }
      //5限
      else if ((hour == 17 && minute >= 10) ||
          (hour == 18) ||
          (hour == 19 && minute < 0)) {
        return display_allclassroom('8');
      }
      else {
        return display_allclassroom('8');
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
