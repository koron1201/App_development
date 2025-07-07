import 'dart:ui';
import 'package:flutter/material.dart';
import 'screen4.dart'; // GlassCard と glass_return_button を使うため
import 'package:flutter/services.dart' show rootBundle; // 追加
import 'package:csv/csv.dart'; // 追加


Future<List<List<dynamic>>> loadCsvData(String path) async {
  final rawData = await rootBundle.loadString(path);
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
  return listData;
}

class CafeteriaKeyaki extends StatefulWidget {
  @override
  _CafeteriaKeyakiState createState() => _CafeteriaKeyakiState();
}

class _CafeteriaKeyakiState extends State<CafeteriaKeyaki> {
  List<String> menus = []; // Stringのリストとして初期化
  bool _isLoading = true; // データロード中の状態を管理

  String _searchQuery = '';

  List<String> get filteredMenus { // Stringのリストを返すように変更
    return menus
        .where((menu) => menu.contains(_searchQuery)) // menu自体で検索
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadMenuData(); // データロードを開始
  }

  Future<void> _loadMenuData() async {
    try {
      final List<List<dynamic>> csvData = await loadCsvData('assets/menu/keyaki_menu.csv');
      setState(() {
        menus = csvData.skip(1).map((row) { // ヘッダー行をスキップ (1行目からデータの場合)
          return row[0].toString(); // 各行の最初の要素（メニュー名）のみを抽出
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading Keyaki menu data: $e');
      setState(() {
        _isLoading = false;
        // エラー処理（例: エラーメッセージを表示、空のリストを維持など）
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('欅(現金のみ)', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.withOpacity(0.85),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF23243A), Color(0xFF0F2027)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Opacity(
              opacity: 0.8,
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          GlassCard(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'メニューを検索',
                                  labelStyle: const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.15),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GlassCard(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'おかず 100gあたり 180円\n'
                                'みそ汁(スープ)     60円\n'
                                'ごはん   1g~200g 120円\n'
                                'ごはん 201g~300g 140円\n'
                                'ごはん 301g~400g 160円\n'
                                'ごはん 401g~500g 180円\n',
                                style: TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator()) // ロード中はインジケーターを表示
                              : GlassCard(
                                  child: SizedBox(
                                    height: 250, // リストの表示領域を固定
                                    child: ListView.builder(
                                      itemCount: filteredMenus.length,
                                      itemBuilder: (context, index) {
                                        final menu = filteredMenus[index];
                                        return ListTile(
                                          title: Text(menu, style: const TextStyle(color: Colors.white)), // 価格表示は不要
                                          leading: const Icon(Icons.restaurant_menu, color: Colors.blueAccent),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          glass_return_button(context),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}