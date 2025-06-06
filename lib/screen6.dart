import 'package:flutter/material.dart';
import 'package:new_sample001/screen_UI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:ui'; // ImageFilterのために必要

class Fuction6_Screen extends StatelessWidget {
  final String title;

  const Fuction6_Screen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // screen5.dartのタイトル表示スタイルを適用
    return MyHomePage(title: title);
  }
}

// screen5.dart から GlassCard ウィジェットをコピー
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  String areaName = '';
  String weather = '';
  double temperature = 0;
  int humidity = 0;
  double temperatureMax = 0;
  double temperatureMin = 0;
  String weatherIcon = '';

  List<String> favoriteAreas = [];
  List<Map<String, dynamic>> weeklyForecast = [];
  List<Map<String, dynamic>> commuteWeather = [];
  String healthAdvice = '';

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  // ===== ここから下のロジック部分は変更ありません =====

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteAreas = prefs.getStringList('favoriteAreas') ?? [];
    });
  }

  Future<void> addFavorite(String area) async {
    if (area.isEmpty || favoriteAreas.contains(area)) return;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteAreas.add(area);
      prefs.setStringList('favoriteAreas', favoriteAreas);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('「$area」をお気に入りに追加しました')),
    );
  }

  Future<void> removeFavorite(String area) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteAreas.remove(area);
      prefs.setStringList('favoriteAreas', favoriteAreas);
    });
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('「$area」をお気に入りから削除しました')),
    );
  }

  Future<void> loadWeeklyForecast(double lat, double lon) async {
    final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=e23698bd91c71b4e9b02283f3474646f&lang=ja&units=metric',
    ));
    if (response.statusCode != 200) {
      setState(() {
        weeklyForecast = [];
        commuteWeather = [];
        healthAdvice = '';
      });
      return;
    }
    final body = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> list = body['list'] ?? [];
    final Map<String, Map<String, dynamic>> daily = {};
    List<Map<String, dynamic>> commuteList = [];
    final now = DateTime.now();
    final today = now.toLocal().toString().split(' ')[0];
    final tomorrow = now.add(Duration(days: 1)).toLocal().toString().split(' ')[0];
    List<double> temps = [];
    List<double> pressures = [];
    for (var item in list) {
      final dtTxt = item['dt_txt'] as String?;
      if (dtTxt == null) continue;
      final date = dtTxt.split(' ')[0];
      if (!daily.containsKey(date)) {
        daily[date] = item;
      }
      final hour = int.tryParse(dtTxt.split(' ')[1].split(':')[0]) ?? -1;
      if ((date == today || date == tomorrow) &&
          ((7 <= hour && hour <= 9) || (17 <= hour && hour <= 19))) {
        commuteList.add(item);
      }
      final main = item['main'] ?? {};
      if (main['temp'] != null) temps.add((main['temp'] as num).toDouble());
      if (main['pressure'] != null) pressures.add((main['pressure'] as num).toDouble());
    }
    String advice = '';
    if (temps.isNotEmpty) {
      final tempMax = temps.reduce((a, b) => a > b ? a : b);
      final tempMin = temps.reduce((a, b) => a < b ? a : b);
      final tempDiff = (tempMax - tempMin).abs();
      if (tempDiff >= 8) {
        advice += '気温差が大きい日が続きます。体調管理に注意しましょう。\n';
      } else if (tempDiff >= 5) {
        advice += 'やや気温差があります。服装で調整しましょう。\n';
      }
    }
    if (pressures.length >= 2) {
      final pressureDiff = pressures.last - pressures.first;
      if (pressureDiff < -5) {
        advice += '気圧が下がる傾向です。頭痛や体調不良に注意。\n';
      } else if (pressureDiff > 5) {
        advice += '気圧が上昇傾向です。体調は安定しやすいです。\n';
      }
    }
    if (advice.isEmpty) advice = '体調管理に気をつけてお過ごしください。';
    setState(() {
      weeklyForecast = daily.values.take(7).toList();
      commuteWeather = commuteList;
      healthAdvice = advice;
    });
  }

  Future<void> loadWeather(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?appid=e23698bd91c71b4e9b02283f3474646f&lang=ja&units=metric&q=$query'));
    if (response.statusCode != 200) {
      setState(() {
        weeklyForecast = [];
      });
      return;
    } else {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final main = (body['main'] ?? {}) as Map<String, dynamic>;
      setState(() {
        areaName = body['name'];
        weather = (body['weather']?[0]?['description'] ?? '') as String;
        humidity = (main['humidity'] ?? 0) as int;
        temperature = (main['temp'] ?? 0) as double;
        temperatureMax = (main['temp_max'] ?? 0) as double;
        temperatureMin = (main['temp_min'] ?? 0) as double;
        weatherIcon = (body['weather']?[0]?['icon'] ?? '') as String;
      });
      final coord = body['coord'] as Map<String, dynamic>?;
      if (coord != null) {
        final lat = coord['lat']?.toDouble();
        final lon = coord['lon']?.toDouble();
        if (lat != null && lon != null) {
          await loadWeeklyForecast(lat, lon);
        }
      }
    }
  }

  // ===== ここから上のロジック部分は変更ありません =====


  @override
  Widget build(BuildContext context) {
    // デザインテーマカラー
    const Color primaryTextColor = Colors.white;
    const Color secondaryTextColor = Colors.white70;
    const Color accentColor = Colors.cyanAccent;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true, // AppBarの背後にもbodyを描画
        backgroundColor: Colors.transparent, // Scaffold自体の背景は透明に
        appBar: AppBar(
          // タイトルをウィジェット名に変更し、スタイルを適用
          title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          flexibleSpace: ClipRRect(
             child: BackdropFilter(
               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
               child: Container(color: Colors.black.withOpacity(0.1)),
             ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                // 検索バー
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: primaryTextColor),
                          decoration: const InputDecoration(
                            hintText: '地域名を入力',
                            hintStyle: TextStyle(color: secondaryTextColor),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              loadWeather(value);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.star, color: primaryTextColor),
                        tooltip: 'お気に入りに追加',
                        onPressed: () {
                          addFavorite(controller.text);
                        },
                      ),
                    ],
                  ),
                ),
                // TabBar
                TabBar(
                  labelColor: accentColor,
                  unselectedLabelColor: secondaryTextColor,
                  indicatorColor: accentColor,
                  isScrollable: true,
                  tabs: const [
                    Tab(icon: Icon(Icons.wb_sunny), text: '現在'),
                    Tab(icon: Icon(Icons.calendar_today), text: '週間'),
                    Tab(icon: Icon(Icons.directions_bus), text: '通学'),
                    Tab(icon: Icon(Icons.favorite), text: 'お気に入り'),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
            // メインコンテンツ
            SafeArea(
              child: TabBarView(
                children: [
                  // 現在の天気
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (weatherIcon.isNotEmpty)
                        Center(
                          child: Image.network(
                            'https://openweathermap.org/img/wn/$weatherIcon@4x.png',
                            width: 120,
                            height: 120,
                            semanticLabel: '天気アイコン',
                          ),
                        ),
                      if(areaName.isNotEmpty) ...[
                      GlassCard(child: ListTile(title: const Text('地域', style: TextStyle(color: secondaryTextColor)), subtitle: Text(areaName, style: const TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold)))),
                      GlassCard(child: ListTile(title: const Text('天気', style: TextStyle(color: secondaryTextColor)), subtitle: Text(weather, style: const TextStyle(color: primaryTextColor, fontSize: 18)))),
                      GlassCard(child: ListTile(title: const Text('温度', style: TextStyle(color: secondaryTextColor)), subtitle: Text('$temperature°C', style: const TextStyle(color: primaryTextColor, fontSize: 18)))),
                      GlassCard(child: ListTile(title: const Text('最高温度', style: TextStyle(color: secondaryTextColor)), subtitle: Text('$temperatureMax°C', style: const TextStyle(color: primaryTextColor, fontSize: 18)))),
                      GlassCard(child: ListTile(title: const Text('最低温度', style: TextStyle(color: secondaryTextColor)), subtitle: Text('$temperatureMin°C', style: const TextStyle(color: primaryTextColor, fontSize: 18)))),
                      GlassCard(child: ListTile(title: const Text('湿度', style: TextStyle(color: secondaryTextColor)), subtitle: Text('$humidity%', style: const TextStyle(color: primaryTextColor, fontSize: 18)))),
                      if (healthAdvice.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                             color: Colors.redAccent.withOpacity(0.1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('体調管理アドバイス', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(healthAdvice, style: const TextStyle(color: Colors.redAccent)),
                            ],
                          ),
                        )
                      ] else
                         Center(child: Text('地域名を入力して天気を検索してください', style: TextStyle(color: secondaryTextColor, fontSize: 16))),
                    ],
                  ),
                  // 週間天気予報
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: weeklyForecast.isNotEmpty
                        ? ListView(
                            children: [
                              const Text('週間天気予報', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor, fontSize: 18)),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 190,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: weeklyForecast.map((item) {
                                    final date = (item['dt_txt'] ?? '').toString().split(' ')[0].substring(5);
                                    final main = item['main'] ?? {};
                                    final weather = (item['weather']?[0]?['description'] ?? '').toString();
                                    final temp = main['temp']?.toString() ?? '';
                                    final icon = (item['weather']?[0]?['icon'] ?? '').toString();
                                    return GlassCard(
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (icon.isNotEmpty)
                                              Image.network('https://openweathermap.org/img/wn/$icon@2x.png', width: 60, height: 60),
                                            Text(date, style: const TextStyle(fontSize: 14, color: primaryTextColor)),
                                            const SizedBox(height: 4),
                                            Flexible(child: Text(weather, style: const TextStyle(fontSize: 13, color: secondaryTextColor), overflow: TextOverflow.ellipsis)),
                                            const SizedBox(height: 4),
                                            Text('$temp°C', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryTextColor)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text('気温グラフ', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor, fontSize: 18)),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 260,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withOpacity(0.1), strokeWidth: 1),
                                      getDrawingVerticalLine: (value) => FlLine(color: Colors.white.withOpacity(0.1), strokeWidth: 1),
                                    ),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 40,
                                          getTitlesWidget: (value, meta) => Text('${value.toInt()}°', style: const TextStyle(color: secondaryTextColor, fontSize: 12)),
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            final idx = value.toInt();
                                            if (idx < 0 || idx >= weeklyForecast.length) return const SizedBox.shrink();
                                            final date = (weeklyForecast[idx]['dt_txt'] ?? '').toString().split(' ')[0].substring(5);
                                            return Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(date, style: const TextStyle(color: secondaryTextColor, fontSize: 10)));
                                          },
                                          reservedSize: 32,
                                        ),
                                      ),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(show: true, border: Border.all(color: Colors.white.withOpacity(0.2))),
                                    minX: 0,
                                    maxX: (weeklyForecast.length - 1).toDouble(),
                                    minY: weeklyForecast.map((e) => (e['main']?['temp'] as num?)?.toDouble() ?? 0).reduce((a, b) => a < b ? a : b) - 2,
                                    maxY: weeklyForecast.map((e) => (e['main']?['temp'] as num?)?.toDouble() ?? 0).reduce((a, b) => a > b ? a : b) + 2,
                                    lineBarsData: [
                                      LineChartBarData(
                                        isCurved: true,
                                        color: accentColor,
                                        barWidth: 4,
                                        dotData: FlDotData(show: true, getDotPainter: (spot, p, bar, i) => FlDotCirclePainter(radius: 4, color: accentColor, strokeWidth: 2, strokeColor: Colors.white)),
                                        belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [accentColor.withOpacity(0.3), accentColor.withOpacity(0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                        spots: [
                                          for (int i = 0; i < weeklyForecast.length; i++)
                                            FlSpot(i.toDouble(), (weeklyForecast[i]['main']?['temp'] as num?)?.toDouble() ?? 0),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(child: Text('週間天気予報データがありません', style: TextStyle(color: secondaryTextColor, fontSize: 16))),
                  ),
                  // 通学時間帯の天気
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (commuteWeather.isNotEmpty) ...[
                        const Text('通学時間帯の天気（今日・明日）', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor, fontSize: 18)),
                        const SizedBox(height: 8),
                        ...commuteWeather.map((item) {
                          final dtTxt = (item['dt_txt'] ?? '').toString();
                          final date = dtTxt.split(' ')[0];
                          final hour = dtTxt.split(' ')[1].substring(0, 5);
                          final main = item['main'] ?? {};
                          final weather = (item['weather']?[0]?['description'] ?? '').toString();
                          final temp = main['temp']?.toString() ?? '';
                          final icon = (item['weather']?[0]?['icon'] ?? '').toString();
                          return GlassCard(
                            child: ListTile(
                              leading: icon.isNotEmpty
                                  ? Image.network('https://openweathermap.org/img/wn/$icon@2x.png', width: 40, height: 40)
                                  : null,
                              title: Text('$date $hour', style: const TextStyle(color: primaryTextColor)),
                              subtitle: Text('$weather / $temp°C', style: const TextStyle(color: secondaryTextColor)),
                            ),
                          );
                        }).toList(),
                      ] else
                         Center(child: Text('通学時間帯の天気データがありません', style: TextStyle(color: secondaryTextColor, fontSize: 16))),
                    ],
                  ),
                  // お気に入り地域
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text('お気に入り地域', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor, fontSize: 18)),
                      const SizedBox(height: 8),
                       if (favoriteAreas.isNotEmpty)
                      ...favoriteAreas.map((area) => GlassCard(
                        child: ListTile(
                          title: Text(area, style: const TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white70),
                            onPressed: () => removeFavorite(area),
                          ),
                          onTap: () async {
                            setState(() {
                              controller.text = area;
                            });
                            await loadWeather(area);
                          },
                        ),
                      ))
                       else
                         Padding(
                           padding: const EdgeInsets.only(top: 32.0),
                           child: Center(
                            child: Text(
                              'お気に入りはまだありません。\n検索してお気に入りを追加しましょう！',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: secondaryTextColor, fontSize: 16),
                            )
                           ),
                         ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}