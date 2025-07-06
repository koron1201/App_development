import 'dart:ui';
import 'package:flutter/material.dart';
import 'screen4.dart'; // GlassCard と glass_return_button を使うため
import 'package:flutter/services.dart' show rootBundle; // 追加
import 'package:csv/csv.dart'; // 追加

// MenuItemクラスの定義
class MenuItem {
  final String name;
  final int price;
  MenuItem({required this.name, required this.price});
}

// CSVデータ読み込みヘルパー関数
Future<List<List<dynamic>>> loadCsvData(String path) async {
  final rawData = await rootBundle.loadString(path);
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
  return listData;
}

class CafeteriaHato extends StatefulWidget {
  @override
  _CafeteriaHatoState createState() => _CafeteriaHatoState();
}

class _CafeteriaHatoState extends State<CafeteriaHato> {
  // 元のハードコードされたリストは不要になります
  // final List<MenuItem> menus = [
  //   MenuItem(name: 'ビーフカレー', price: 700),
  //   MenuItem(name: 'チキンカレー', price: 650),
  //   // ... (その他の既存メニュー)
  // ];

  List<MenuItem> menus = []; // MenuItemのリストとして初期化
  bool _isLoading = true; // データロード中の状態を管理

  String _searchQuery = '';
  int? _minPrice;
  int? _maxPrice;

  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  List<MenuItem> get filteredMenus {
    return menus.where((item) {
      final matchesName = item.name.contains(_searchQuery);
      final matchesMin = _minPrice == null || item.price >= _minPrice!;
      final matchesMax = _maxPrice == null || item.price <= _maxPrice!;
      return matchesName && matchesMin && matchesMax;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadMenuData(); // データロードを開始
  }

  Future<void> _loadMenuData() async {
    try {
      final List<List<dynamic>> csvData = await loadCsvData('assets/menu/hato_menu.csv');
      setState(() {
        // ヘッダー行をスキップ (1行目からデータの場合)
        menus = csvData.skip(1).map((row) {
          return MenuItem(
            name: row[0].toString(),
            price: int.tryParse(row[1].toString()) ?? 0, // priceが数値でない場合0に
          );
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading Hato menu data: $e');
      setState(() {
        _isLoading = false;
        // エラー処理（例: エラーメッセージを表示、空のリストを維持など）
      });
    }
  }

  void _onPriceChanged() {
    setState(() {
      _minPrice = int.tryParse(_minPriceController.text);
      _maxPrice = int.tryParse(_maxPriceController.text);
    });
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('hatocafe(電子マネー対応)', style: TextStyle(fontWeight: FontWeight.bold)),
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
                          Row(
                            children: [
                              Expanded(
                                child: GlassCard(
                                  child: TextField(
                                    controller: _minPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: '最低価格',
                                      labelStyle: const TextStyle(color: Colors.white70),
                                      prefixIcon: const Icon(Icons.attach_money, color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.15),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (_) => _onPriceChanged(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GlassCard(
                                  child: TextField(
                                    controller: _maxPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: '最高価格',
                                      labelStyle: const TextStyle(color: Colors.white70),
                                      prefixIcon: const Icon(Icons.money_off, color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.15),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (_) => _onPriceChanged(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator()) // ロード中はインジケーターを表示
                              : GlassCard(
                                  child: SizedBox(
                                    height: 250, // 適度な高さを設定
                                    child: ListView.builder(
                                      itemCount: filteredMenus.length,
                                      itemBuilder: (context, index) {
                                        final menu = filteredMenus[index];
                                        return ListTile(
                                          title: Text(menu.name, style: const TextStyle(color: Colors.white)),
                                          trailing: Text('${menu.price}円', style: const TextStyle(color: Colors.cyanAccent)),
                                          leading: const Icon(Icons.local_cafe, color: Colors.pinkAccent),
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