import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:new_sample001/screen1_gpa_calc.dart';
import 'package:new_sample001/screen_UI.dart';

class Function1_Screen extends StatefulWidget {
  final String title;
  const Function1_Screen({super.key, required this.title});
  @override
  Screen1_Structure createState() => Screen1_Structure();
}

class Screen1_Structure extends State<Function1_Screen> {
  final List<TextEditingController> listControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  double gpaCount = 0.0;
  @override
  void dispose() {
    for (final controller in listControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget calc_start_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          final credits =
              listControllers.map((c) => double.tryParse(c.text) ?? 0.0).toList();
          gpaCount = GPA_calc(credits);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: Colors.cyanAccent.withOpacity(0.4),
      ),
      child: const Text('GPAを計算', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget InputList(BuildContext context, List<TextEditingController> controllers) {
    return Column(
      children: List.generate(controllers.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GlassCard(
            child: Row(
              children: [
                Text('GP$index', style: const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: '単位数',
                      hintText: '例: 10',
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.cyan.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.cyan.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
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
          child: const Text('戻る', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
          // メインUI
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        child: Column(
                          children: const [
                            Text(
                              '各GPの単位数を入力してください。\nGP = グレードポイント',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    InputList(context, listControllers),
                    const SizedBox(height: 36),
                    calc_start_button(context),
                    const SizedBox(height: 36),
                    GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              'GPA: ${gpaCount.toStringAsFixed(3)}',
                              style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent,
                                shadows: [
                                  Shadow(
                                    color: Colors.cyan,
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
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
          colors: [Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.04)],
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
