import 'dart:ui';
import 'package:flutter/material.dart';
import 'screen4.dart'; // GlassCard と glass_return_button を使うため

class CafeteriaKeyaki extends StatefulWidget {
  @override
  _CafeteriaKeyakiState createState() => _CafeteriaKeyakiState();
}

class _CafeteriaKeyakiState extends State<CafeteriaKeyaki> {
  final List<String> menus = [
    'からあげ',
    'ハンバーグ',
    'ピーマンの肉詰め',
    '男爵コロッケ',
    'サラダ',
    '麻婆',
  ];

  String _searchQuery = '';

  List<String> get filteredMenus {
    return menus
        .where((menu) => menu.contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('欅', style: TextStyle(fontWeight: FontWeight.bold)),
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
              child: SingleChildScrollView( // <--- 追加
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
                    const SizedBox(height: 16),
                    GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'おかず 100gあたり 180円\n'
                          'みそ汁 60円\n'
                          'ごはん 1g~200g 120円\n'
                          'ごはん 201g~300g 140円\n'
                          'ごはん 301g~400g 160円\n'
                          'ごはん 401g~500g 180円\n',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassCard(
                      child: SizedBox( // <--- Expanded の代わりに SizedBox を使用
                        height: 250, // 適度な高さを設定
                        child: ListView.builder(
                          itemCount: filteredMenus.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredMenus[index], style: const TextStyle(color: Colors.white)),
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
            ),
          ),
        ],
      ),
    );
  }
}