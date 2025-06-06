// lib/calendar_page.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// カレンダー上に表示する「イベント」モデル：タイトル＋色
class Event {
  final String title;  // イベント名
  final Color color;   // ドットの色
  Event(this.title, this.color);
  @override
  String toString() => title;
}

class CalendarPage extends StatefulWidget {
  final Map<DateTime, List<Event>> events;  // 日付ごとのイベントマップ
  const CalendarPage({super.key, required this.events});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();  // カレンダーでフォーカス中の日
  DateTime? _selectedDay;                 // ユーザーが選択した日

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // 初期選択日のイベントを通知リスナーにセット
    _selectedEvents = ValueNotifier(_getEvents(_focusedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // 指定した日付のイベント一覧を返す
  List<Event> _getEvents(DateTime day) {
    return widget.events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── カレンダー本体 ──
          TableCalendar<Event>(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            // 日付が選択されたかどうかの判定
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            // 読み込むイベント
            eventLoader: _getEvents,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // 選択日のイベントを更新
                _selectedEvents.value = _getEvents(selectedDay);
              });
            },
            // 日付下のドットをイベントごとに色分け
            calendarBuilders: CalendarBuilders<Event>(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return const SizedBox.shrink();
                return Positioned(
                  bottom: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: events.map((event) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: event.color,
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // ── 選択日のイベント一覧 ──
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return const Center(child: Text('予定がありません'));
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final ev = value[index];
                    return ListTile(
                      leading: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ev.color,
                        ),
                      ),
                      title: Text(ev.title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
