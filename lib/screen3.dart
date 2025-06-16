// lib/todo_page.dart

import 'dart:convert'; // JSON の encode/decode 用
import 'dart:io'; // ファイル IO 用
import 'dart:ui';
import 'package:flutter/material.dart'; // Flutter UI
import 'package:path_provider/path_provider.dart'; // ストレージパス取得用
import 'calendar_page.dart'; // カレンダー画面

/// ─────────────────────────────────────────────
/// Todo 項目モデル
/// ─────────────────────────────────────────────
class TodoItem {
  String text; // タスク名
  bool isDone; // 完了チェック
  DateTime? start; // 開始日時（任意）
  DateTime? end; // 終了日時（任意）

  TodoItem({required this.text, this.isDone = false, this.start, this.end});

  // JSON に変換
  Map<String, dynamic> toJson() => {
    'text': text,
    'isDone': isDone,
    'start': start?.toIso8601String(),
    'end': end?.toIso8601String(),
  };

  // JSON から復元
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      text: json['text'] as String,
      isDone: json['isDone'] as bool,
      start: json['start'] != null ? DateTime.parse(json['start']) : null,
      end: json['end'] != null ? DateTime.parse(json['end']) : null,
    );
  }
}

/// ─────────────────────────────────────────────
/// Todo リスト画面
/// ─────────────────────────────────────────────
class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key); // const コンストラクタ

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Drawer 操作用キー

  // カテゴリ一覧・選択中カテゴリ
  List<String> _categories = ['デフォルト'];
  String _currentCategory = 'デフォルト';

  // 入力コントローラ・Todo データ・一時日時保管
  final TextEditingController _controller = TextEditingController();
  List<TodoItem> _todos = [];
  DateTime? _pickedStart;
  DateTime? _pickedEnd;

  @override
  void initState() {
    super.initState();
    _loadTodos(); // 起動時に永続化データを読み込む
  }

  /// 保存先ファイルパス取得
  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = 'todos_${_currentCategory.replaceAll(' ', '_')}.json';
    return File('${dir.path}/$filename');
  }

  /// ファイルから Todo を読み込む
  Future<void> _loadTodos() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        final decoded = json.decode(jsonStr) as List;
        setState(() {
          _todos =
              decoded
                  .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
                  .toList();
        });
      } else {
        setState(() => _todos = []);
      }
    } catch (_) {
      // 読み込みエラーは無視
    }
  }

  /// Todo をファイルに保存
  Future<void> _saveTodos() async {
    final file = await _localFile;
    final jsonStr = json.encode(_todos.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonStr);
  }

  /// カテゴリ名のリネームダイアログ
  Future<void> _renameCategory() async {
    final oldName = _currentCategory;
    final nameController = TextEditingController(text: oldName);

    final newName = await showDialog<String>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('リスト名を変更'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: '新しいリスト名'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, nameController.text.trim()),
                child: const Text('変更'),
              ),
            ],
          ),
    );

    if (newName != null && newName.isNotEmpty && newName != oldName) {
      final dir = await getApplicationDocumentsDirectory();
      final oldFile = File(
        '${dir.path}/todos_${oldName.replaceAll(' ', '_')}.json',
      );
      final newFile = File(
        '${dir.path}/todos_${newName.replaceAll(' ', '_')}.json',
      );
      if (await oldFile.exists()) {
        await oldFile.rename(newFile.path); // ファイル名もリネーム
      }
      setState(() {
        final idx = _categories.indexOf(oldName);
        if (idx != -1) _categories[idx] = newName;
        _currentCategory = newName;
      });
      await _loadTodos(); // 新ファイルを読み込む
    }
  }

  /// 新規カテゴリ作成ダイアログ
  Future<void> _createNewCategory() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('新しいリスト名を入力'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: '例：仕事、買い物'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, nameController.text.trim()),
                child: const Text('作成'),
              ),
            ],
          ),
    );
    if (name != null && name.isNotEmpty) {
      setState(() {
        _categories.add(name);
        _currentCategory = name;
        _todos = [];
      });
      await _saveTodos();
    }
  }

  /// タスク追加処理
  Future<void> _handleAddTodo() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final wantDeadline = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('期限を設定しますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('いいえ'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('はい'),
              ),
            ],
          ),
    );
    if (wantDeadline == true) {
      await _pickDateRange();
    }

    setState(() {
      _todos.add(TodoItem(text: text, start: _pickedStart, end: _pickedEnd));
      _controller.clear();
      _pickedStart = null;
      _pickedEnd = null;
    });
    await _saveTodos();
  }

  /// 日時選択ダイアログ
  Future<void> _pickDateRange() async {
    final date1 = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (date1 == null) return;
    final time1 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time1 == null) return;
    final date2 = await showDatePicker(
      context: context,
      firstDate: date1,
      lastDate: DateTime(2100),
      initialDate: date1,
    );
    if (date2 == null) return;
    final time2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: time1.hour, minute: time1.minute),
    );
    if (time2 == null) return;

    setState(() {
      _pickedStart = DateTime(
        date1.year,
        date1.month,
        date1.day,
        time1.hour,
        time1.minute,
      );
      _pickedEnd = DateTime(
        date2.year,
        date2.month,
        date2.day,
        time2.hour,
        time2.minute,
      );
    });
  }

  /// 並び替え
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _todos.removeAt(oldIndex);
      _todos.insert(newIndex, item);
    });
    _saveTodos();
  }

  /// 完了チェック切替
  void _toggleDone(int idx, bool? val) {
    setState(() => _todos[idx].isDone = val ?? false);
    _saveTodos();
  }

  /// 削除
  void _deleteTodo(int idx) {
    setState(() => _todos.removeAt(idx));
    _saveTodos();
  }

  Widget glass_return_button(BuildContext context) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.withOpacity(0.7),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            shadowColor: Colors.greenAccent.withOpacity(0.3),
          ),
          child: const Text(
            '戻る',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildInputRow() {
    // double sw を削除
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Todoを入力',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _handleAddTodo(),
          ),
        ),
        const SizedBox(width: 12), // sw * 0.02 を固定値に変更
        ElevatedButton(
          onPressed: _handleAddTodo,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan[700], // 色を調整
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ), // パディングを調整
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: Colors.cyanAccent.withOpacity(0.4),
          ),
          child: const Text(
            '追加',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTodoList() {
    // double sw, double sh を削除
    if (_todos.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'Todoがありません',
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ),
      ); // スタイルを調整
    }
    return Expanded(
      child: ReorderableListView.builder(
        onReorder: _onReorder,
        itemCount: _todos.length,
        itemBuilder:
            (ctx, i) => GlassCard(
              key: ValueKey(_todos[i].text + i.toString()),
              child: ListTile(
                key: ValueKey(_todos[i]), // keyを追加
                leading: Checkbox(
                  value: _todos[i].isDone,
                  onChanged: (v) => _toggleDone(i, v),
                  activeColor: Colors.cyanAccent,
                  checkColor: Colors.black87,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _todos[i].text,
                      style: TextStyle(
                        fontSize: 16, // サイズを調整
                        color: _todos[i].isDone ? Colors.white54 : Colors.white,
                        decoration:
                            _todos[i].isDone
                                ? TextDecoration.lineThrough
                                : null,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_todos[i].start != null &&
                        _todos[i].end != null) // 日時表示を追加
                      Text(
                        '${_todos[i].start!.year}/${_todos[i].start!.month.toString().padLeft(2, '0')}/${_todos[i].start!.day.toString().padLeft(2, '0')} ${_todos[i].start!.hour.toString().padLeft(2, '0')}:${_todos[i].start!.minute.toString().padLeft(2, '0')} 〜 ${_todos[i].end!.year}/${_todos[i].end!.month.toString().padLeft(2, '0')}/${_todos[i].end!.day.toString().padLeft(2, '0')} ${_todos[i].end!.hour.toString().padLeft(2, '0')}:${_todos[i].end!.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                      ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _deleteTodo(i),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildCalendarFab() {
    return FloatingActionButton(
      tooltip: 'カレンダーで確認',
      backgroundColor: Colors.purpleAccent.withOpacity(0.7), // 色を調整
      foregroundColor: Colors.white,
      elevation: 8,
      child: const Icon(Icons.calendar_month, size: 28),
      onPressed: () {
        final events = <DateTime, List<Event>>{};
        for (var i = 0; i < _todos.length; i++) {
          final t = _todos[i];
          if (t.start != null) {
            final key = DateTime(t.start!.year, t.start!.month, t.start!.day);
            events
                .putIfAbsent(key, () => [])
                .add(
                  Event(t.text, Colors.primaries[i % Colors.primaries.length]),
                );
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CalendarPage(events: events)),
        );
      },
    );
  }

  Widget _buildDrawerButton() {
    // Drawerを開くFABを追加
    return FloatingActionButton(
      heroTag: 'openDrawer',
      backgroundColor: Colors.blueAccent.withOpacity(0.7), // 色を調整
      foregroundColor: Colors.white,
      elevation: 8,
      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      tooltip: 'リストメニュー',
      child: const Icon(Icons.menu, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffoldにkeyを割り当て
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'ToDoリスト',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 背景グラデーション
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF23243A), Color(0xFF0F2027)],
                ),
              ),
            ),
          ),
          // 装飾的なグラデーションエフェクト
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan.withOpacity(0.18),
                    Colors.blue.withOpacity(0.10),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.13),
                    Colors.pink.withOpacity(0.10),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // メインUI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 24,
              ), // SingleChildScrollViewはColumn内に移動
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  // リスト名表示（GlassCard化）
                  GestureDetector(
                    onTap: _renameCategory,
                    child: GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 8,
                        ),
                        child: Text(
                          _currentCategory,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // 入力行 (GlassCard化)
                  GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: _buildInputRow(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // ToDoリスト (GlassCard化は_buildTodoList内で実施)
                  _buildTodoList(),
                  const SizedBox(height: 36),
                  // 戻るボタン
                  glass_return_button(context),
                ],
              ),
            ),
          ),
        ],
      ),
      // Drawer（メニュー）
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF23243A), Color(0xFF0F2027)],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // DrawerHeaderもGlass風に調整
                GlassCard(
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blueGrey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'リストメニュー',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // 新規リスト作成ボタン (GlassCard化)
                GlassCard(
                  child: ListTile(
                    leading: const Icon(Icons.add, color: Colors.cyanAccent),
                    title: const Text(
                      '新規リスト作成',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _createNewCategory();
                    },
                  ),
                ),
                const Divider(color: Colors.white10),
                // カテゴリ一覧 (GlassCard化)
                Expanded(
                  child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (ctx, i) {
                      final name = _categories[i];
                      return GlassCard(
                        child: ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                              color:
                                  name == _currentCategory
                                      ? Colors.cyanAccent
                                      : Colors.white,
                              fontWeight:
                                  name == _currentCategory
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                          selected: name == _currentCategory,
                          onTap: () async {
                            Navigator.pop(ctx);
                            setState(() => _currentCategory = name);
                            await _loadTodos();
                          },
                          selectedColor: Colors.cyanAccent, // 選択時の色を調整
                          selectedTileColor: Colors.white.withOpacity(
                            0.08,
                          ), // 選択時の背景色を調整
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // FloatingActionButton (カレンダーとDrawerボタンをStackで重ねる)
      floatingActionButton: Stack(
        children: [
          Positioned(bottom: 16, right: 16, child: _buildCalendarFab()),
          Positioned(
            bottom: 16,
            left: 16,
            child: _buildDrawerButton(), // Drawerを開くボタンを左下に配置
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .miniStartFloat, // FABの位置調整（Stackを使う場合はあまり影響しないかも）
    );
  }
}

// GlassCardウィジェットは以前の定義を使用
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.2),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.10),
            Colors.white.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: child,
        ),
      ),
    );
  }
}
