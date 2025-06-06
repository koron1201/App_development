import 'package:flutter/material.dart';
import 'package:new_sample001/screen1.dart';
import 'package:new_sample001/screen2.dart';
import 'package:new_sample001/screen3.dart';
import 'package:new_sample001/screen4.dart';
import 'package:new_sample001/screen5.dart';
import 'package:new_sample001/screen6.dart';
import 'dart:ui';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'GPAの計算',
        'icon': Icons.calculate,
        'color': [Colors.cyan, Colors.blue],
        'glow': Colors.cyanAccent.withOpacity(0.4),
        'screen': Function1_Screen(title: 'GPAの計算'),
      },
      {
        'title': '現在の空き教室',
        'icon': Icons.meeting_room,
        'color': [Colors.purple, Colors.indigo],
        'glow': Colors.purpleAccent.withOpacity(0.4),
        'screen': Fuction2_Screen(title: '現在の空き教室'),
      },
      {
        'title': 'ToDoリスト',
        'icon': Icons.check_box,
        'color': [Colors.green, Colors.teal],
        'glow': Colors.greenAccent.withOpacity(0.4),
        'screen': TodoPage(),
      },
      {
        'title': '食堂',
        'icon': Icons.restaurant,
        'color': [Colors.orange, Colors.red],
        'glow': Colors.orangeAccent.withOpacity(0.4),
        'screen': Function4_Screen(title: '食堂'),
      },
      {
        'title': 'ブックマーク',
        'icon': Icons.bookmark,
        'color': [Colors.pink, Colors.redAccent],
        'glow': Colors.pinkAccent.withOpacity(0.4),
        'screen': Fuction5_Screen(title: 'ブックマーク'),
      },
      {
        'title': '天気予報',
        'icon': Icons.cloud,
        'color': [Colors.blue, Colors.cyan],
        'glow': Colors.blueAccent.withOpacity(0.4),
        'screen': Fuction6_Screen(title: '天気予報'),
      },
    ];

    return Scaffold(
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
            top: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan.withOpacity(0.15), Colors.blue.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.withOpacity(0.12), Colors.pink.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: 100,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.withOpacity(0.10), Colors.teal.withOpacity(0.10)],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // グリッドパターン
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
          ),
          // メインUI
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Column(
                  children: [
                    // ヘッダー
                    const SizedBox(height: 10),
                    Text(
                      'DASHBOARD',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Colors.white, Colors.cyanAccent],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '学生生活管理システム',
                      style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1),
                    ),
                    const SizedBox(height: 24),
                    // メニューグリッド
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, idx) {
                        final item = menuItems[idx];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => item['screen'] as Widget),
                            );
                          },
                          child: GlassMenuCard(
                            title: item['title'] as String,
                            icon: item['icon'] as IconData,
                            colors: item['color'] as List<Color>,
                            glow: item['glow'] as Color,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
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

class GlassMenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> colors;
  final Color glow;
  const GlassMenuCard({super.key, required this.title, required this.icon, required this.colors, required this.glow});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.5),
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: glow,
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: glow,
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 34),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.10)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}