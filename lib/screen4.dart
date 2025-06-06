import 'package:flutter/material.dart';
import 'package:new_sample001/screen_UI.dart';

class MenuItem {
  final String name;
  final int price; // 値段を整数で管理

  MenuItem({required this.name, required this.price});
}

final Map<String, List<MenuItem>> cafeteriaMenus = {
  '欅': [
    MenuItem(name: 'からあげ', price: 0),
    MenuItem(name: 'ハンバーグ', price: 0),
    MenuItem(name: 'ピーマンの肉詰め', price: 0),
    MenuItem(name: '男爵コロッケ', price: 0),
    MenuItem(name: 'サラダ', price: 0),
    MenuItem(name: '麻婆', price: 0),
  ],
  'komorebi': [
    MenuItem(name: 'ラーメン', price: 600),
    MenuItem(name: 'チャーハン', price: 550),
  ],
  'HATO CAFE': [
    MenuItem(name: 'オムライス', price: 650),
    MenuItem(name: 'うどん', price: 400),
  ],
};

class Function4_Screen extends StatefulWidget {
  final String title;

  const Function4_Screen({super.key, required this.title});

  @override
  _Function4_Screen createState() => _Function4_Screen();
}

class _Function4_Screen extends State<Function4_Screen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  String _searchQuery = '';
  int? _minPrice; // 下限価格（nullは指定なし）
  int? _maxPrice; // 上限価格

  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: cafeteriaMenus.length, vsync: this);

    // タブ変更時にUIを更新するためのリスナー
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<MenuItem> getFilteredMenus(String cafeteria) {
    final menus = cafeteriaMenus[cafeteria] ?? [];
    return menus.where((item) {
      final matchesName = item.name.contains(_searchQuery);
      final matchesMinPrice = _minPrice == null || item.price >= _minPrice!;
      final matchesMaxPrice = _maxPrice == null || item.price <= _maxPrice!;
      return matchesName && matchesMinPrice && matchesMaxPrice;
    }).toList();
  }

  void _onPriceChanged() {
    setState(() {
      _minPrice = int.tryParse(_minPriceController.text);
      _maxPrice = int.tryParse(_maxPriceController.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    final cafeteriaNames = cafeteriaMenus.keys.toList();
    final currentTab = cafeteriaNames[_tabController.index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('食堂メニュー'),
        bottom: TabBar(
          controller: _tabController,
          tabs: cafeteriaNames.map((name) => Tab(text: name)).toList(),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.lightBlue[50], // 背景色をここで指定
        child: Column(
          children: [
            // メニュー名検索欄（常に表示）
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'メニュー名で検索',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchQuery = text;
                  });
                },
              ),
            ),

            if (currentTab == '欅')
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'おかず 100gあたり 180円\n'
                      'みそ汁 60円\n'
                      'ごはん 1g~200g 120円\n'
                      'ごはん 201g~300g 140円\n'
                      'ごはん 301g~400g 160円\n'
                      'ごはん 401g~500g 180円\n',
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),

            // 「欅」以外のときだけ価格絞り込みUIを表示
            if (currentTab != '欅')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '最低価格',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _onPriceChanged(),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('〜'),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '最高価格',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _onPriceChanged(),
                      ),
                    ),
                  ],
                ),
              ),

            // メニューリスト
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: cafeteriaNames.map((cafeteria) {
                  final filteredMenus = getFilteredMenus(cafeteria);
                  return ListView.builder(
                    itemCount: filteredMenus.length,
                    itemBuilder: (context, index) {
                      final menu = filteredMenus[index];
                      return ListTile(
                        title: Text(menu.name),
                        trailing: cafeteria == '欅' ? null : Text('${menu.price} 円'),
                        leading: Icon(Icons.restaurant_menu),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // 戻るボタン
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: return_button(context),
            ),
          ],
        ),
      ),
    );
  }
}
