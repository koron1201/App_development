import 'dart:ui';
import 'package:flutter/material.dart';
import 'screen4.dart';

class MenuItem {
  final String name;
  final int price;
  MenuItem({required this.name, required this.price});
}

class CafeteriaHato extends StatefulWidget {
  @override
  _CafeteriaHatoState createState() => _CafeteriaHatoState();
}

class _CafeteriaHatoState extends State<CafeteriaHato> {
  final List<MenuItem> menus = [
    MenuItem(name: 'ビーフカレー', price: 700),
    MenuItem(name: 'チキンカレー', price: 650),
    MenuItem(name: 'ハンバーグステーキ', price: 900),
    MenuItem(name: 'サンドイッチセット', price: 500),
    MenuItem(name: 'コーヒー', price: 350),
    MenuItem(name: '紅茶', price: 300),
  ];

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
        title: const Text('HATO CAFE', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan.withOpacity(0.18), Colors.blue.withOpacity(0.10)],
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
                  colors: [Colors.purple.withOpacity(0.13), Colors.pink.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'メニュー検索',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GlassCard(
                          child: TextField(
                            controller: _minPriceController,
                            decoration: const InputDecoration(
                              labelText: '最小価格',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyanAccent),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => _onPriceChanged(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GlassCard(
                          child: TextField(
                            controller: _maxPriceController,
                            decoration: const InputDecoration(
                              labelText: '最大価格',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyanAccent),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => _onPriceChanged(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GlassCard(
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
          ),
        ],
      ),
    );
  }

  Widget glass_return_button(BuildContext context) {
    return GlassCard(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent.withOpacity(0.7),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            shadowColor: Colors.greenAccent.withOpacity(0.3),
          ),
          child: const Text('戻る', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
