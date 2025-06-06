// lib/screen5.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';

// GlassCardウィジェットを追加
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

// Fuction5_Screen はブックマークリスト表示と編集・追加・削除を担当
class Fuction5_Screen extends StatefulWidget {
  final String title;
  const Fuction5_Screen({super.key, required this.title});

  @override
  State<Fuction5_Screen> createState() => _Fuction5_ScreenState();
}

class _Fuction5_ScreenState extends State<Fuction5_Screen> {
  final Stream<QuerySnapshot> _bookmarksStream =
      FirebaseFirestore.instance
          .collection('bookmarks')
          .orderBy('createdAt', descending: true)
          .snapshots();

  Future<void> _showEditDialog(
    BuildContext context,
    DocumentSnapshot bookmarkDoc,
  ) async {
    final String docId = bookmarkDoc.id;
    final Map<String, dynamic> data =
        bookmarkDoc.data() as Map<String, dynamic>;
    final String dialogTitle = data['title'] ?? 'ブックマーク編集';

    final TextEditingController titleController = TextEditingController(
      text: data['title'] ?? '',
    );
    final TextEditingController urlController = TextEditingController(
      text: data['url'] ?? '',
    );
    final TextEditingController usernameController = TextEditingController(
      text: data['username'] ?? '',
    );
    final TextEditingController passwordController = TextEditingController(
      text: data['password'] ?? '',
    );
    final TextEditingController usernameSelectorController = TextEditingController(
      text: data['usernameSelector'] ?? "input[id='username']",
    );
    final TextEditingController passwordSelectorController = TextEditingController(
      text: data['passwordSelector'] ?? "input[id='password']",
    );
    final TextEditingController loginButtonSelectorController = TextEditingController(
      text: data['loginButtonSelector'] ?? "button[id='loginbtn']",
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF23243A),
          title: Text(dialogTitle, style: const TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: urlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'URL',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.person, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.lock, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: usernameSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名セレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'パスワードセレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: loginButtonSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ログインボタンセレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '⚠️ 注意: パスワードは暗号化されずに保存されます。',
                  style: TextStyle(fontSize: 12, color: Colors.redAccent),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.withOpacity(0.7),
                foregroundColor: Colors.black,
              ),
              child: const Text('保存'),
              onPressed: () async {
                final newTitle = titleController.text;
                final newUrl = urlController.text;
                final newUsername = usernameController.text;
                final newPassword = passwordController.text;
                final newUsernameSelector = usernameSelectorController.text;
                final newPasswordSelector = passwordSelectorController.text;
                final newLoginButtonSelector = loginButtonSelectorController.text;

                if (newTitle.isEmpty || newUrl.isEmpty) {
                  if (dialogContext.mounted) {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(content: Text('タイトルとURLは必須です。')),
                    );
                  }
                  return;
                }

                try {
                  await FirebaseFirestore.instance
                      .collection('bookmarks')
                      .doc(docId)
                      .update({
                        'title': newTitle,
                        'url': newUrl,
                        'username': newUsername,
                        'password': newPassword,
                        'usernameSelector': newUsernameSelector,
                        'passwordSelector': newPasswordSelector,
                        'loginButtonSelector': newLoginButtonSelector,
                      });
                  Navigator.of(dialogContext).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('「$newTitle」を更新しました')),
                    );
                  }
                } catch (e) {
                  print('Error updating Firestore: $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('更新に失敗しました: $e')));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddBookmarkDialog(BuildContext context) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController urlController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameSelectorController = TextEditingController();
    final TextEditingController passwordSelectorController = TextEditingController();
    final TextEditingController loginButtonSelectorController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF23243A),
          title: const Text('新しいブックマークを追加', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'タイトル *',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                TextField(
                  controller: urlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'URL *',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                TextField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.person, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.lock, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: usernameSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名セレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                TextField(
                  controller: passwordSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'パスワードセレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
                TextField(
                  controller: loginButtonSelectorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'ログインボタンセレクタ',
                    labelStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.code, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent.withOpacity(0.7),
                foregroundColor: Colors.black,
              ),
              child: const Text('追加'),
              onPressed: () async {
                final title = titleController.text;
                final url = urlController.text;
                final username = usernameController.text;
                final password = passwordController.text;
                final usernameSelector = usernameSelectorController.text;
                final passwordSelector = passwordSelectorController.text;
                final loginButtonSelector = loginButtonSelectorController.text;

                if (title.isNotEmpty && url.isNotEmpty) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('bookmarks')
                        .add({
                          'title': title,
                          'url': url,
                          'username': username,
                          'password': password,
                          'usernameSelector': usernameSelector,
                          'passwordSelector': passwordSelector,
                          'loginButtonSelector': loginButtonSelector,
                          'createdAt': FieldValue.serverTimestamp(),
                        });
                    Navigator.of(dialogContext).pop();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('「$title」を追加しました')),
                      );
                    }
                  } catch (e) {
                    print('Error adding bookmark: $e');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ブックマークの追加に失敗しました: $e')),
                      );
                    }
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('タイトルとURLは必須です')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
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
          // メインコンテンツ
          StreamBuilder<QuerySnapshot>(
            stream: _bookmarksStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(child: Text('エラーが発生しました: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_add_outlined,
                          size: 60,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ブックマークはまだありません。\n画面右下の「追加」ボタンから\n新しいブックマークを登録しましょう！',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final bookmarks = snapshot.data!.docs;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                itemCount: bookmarks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final bookmarkDoc = bookmarks[index];
                  final bookmarkData = bookmarkDoc.data() as Map<String, dynamic>? ?? {};
                  final title = bookmarkData['title'] as String? ?? 'タイトルなし';
                  final url = bookmarkData['url'] as String? ?? '';
                  final username = bookmarkData['username'] as String? ?? '';
                  final password = bookmarkData['password'] as String? ?? '';
                  final usernameSelector = bookmarkData['usernameSelector'] as String? ?? "input[id='username']";
                  final passwordSelector = bookmarkData['passwordSelector'] as String? ?? "input[id='password']";
                  final loginButtonSelector = bookmarkData['loginButtonSelector'] as String? ?? "button[id='loginbtn']";

                  return GlassCard(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                        child: Icon(
                          Icons.link,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            url,
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (username.isNotEmpty || password.isNotEmpty)
                            const SizedBox(height: 4),
                          if (username.isNotEmpty)
                            Text(
                              'ユーザー名: $username',
                              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7)),
                            ),
                          if (password.isNotEmpty)
                            Text(
                              'パスワード: ${'*' * password.length}',
                              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7)),
                            ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.white.withOpacity(0.7)),
                        tooltip: "メニュー",
                        color: const Color(0xFF23243A),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditDialog(context, bookmarkDoc);
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) => AlertDialog(
                                backgroundColor: const Color(0xFF23243A),
                                title: Text('「$title」を削除しますか？', style: const TextStyle(color: Colors.white)),
                                content: const Text('この操作は元に戻せません。', style: TextStyle(color: Colors.white70)),
                                actions: [
                                  TextButton(
                                    child: const Text('キャンセル', style: TextStyle(color: Colors.white70)),
                                    onPressed: () => Navigator.of(dialogContext).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('削除', style: TextStyle(color: Colors.redAccent)),
                                    onPressed: () async {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('bookmarks')
                                            .doc(bookmarkDoc.id)
                                            .delete();
                                        Navigator.of(dialogContext).pop();
                                        if (context.mounted)
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('「$title」を削除しました')),
                                          );
                                      } catch (e) {
                                        if (context.mounted)
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('削除に失敗しました: $e')),
                                          );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: ListTile(
                              leading: const Icon(Icons.edit_outlined, color: Colors.cyanAccent),
                              title: const Text('認証情報編集', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: ListTile(
                              leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                              title: const Text('削除', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (url.isNotEmpty && Uri.tryParse(url)?.isAbsolute == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(
                                title: title,
                                url: url,
                                username: username,
                                password: password,
                                usernameSelector: usernameSelector,
                                passwordSelector: passwordSelector,
                                loginButtonSelector: loginButtonSelector,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('有効なURLではありません')),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBookmarkDialog(context),
        icon: const Icon(Icons.add_link_sharp),
        label: const Text("新規追加"),
        backgroundColor: Colors.cyanAccent.withOpacity(0.7),
        foregroundColor: Colors.black,
        elevation: 8,
        tooltip: '新しいブックマークを追加',
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    required this.title,
    required this.url,
    required this.username,
    required this.password,
    required this.usernameSelector,
    required this.passwordSelector,
    required this.loginButtonSelector,
    super.key,
  });
  final String title;
  final String url;
  final String username;
  final String password;
  final String usernameSelector;
  final String passwordSelector;
  final String loginButtonSelector;
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  bool _isLoadingPage = true;
  bool _isAutoFilling = false;
  bool _scriptExecutedForThisPageInstance = false;

  @override
  void initState() {
    super.initState();

    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                if (mounted) {
                  setState(() {
                    _isLoadingPage = true;
                  });
                }
              },
              onPageFinished: (String url) async {
                if (mounted) {
                  setState(() {
                    _isLoadingPage = false;
                  });
                }

                if (!_scriptExecutedForThisPageInstance &&
                    (widget.username.isNotEmpty ||
                        widget.password.isNotEmpty) &&
                    mounted) {
                  _scriptExecutedForThisPageInstance = true;

                  setState(() {
                    _isAutoFilling = true;
                  });

                  final String usernameSelectorString = widget.usernameSelector;
                  final String passwordSelectorString = widget.passwordSelector;
                  final String loginButtonSelectorString = widget.loginButtonSelector;

                  String script = """
(function(){
  let start = Date.now();
  let interval = setInterval(function() {
    var uField = document.querySelector(\"$usernameSelectorString\");
    var pField = document.querySelector(\"$passwordSelectorString\");
    var loginButton = document.querySelector(\"$loginButtonSelectorString\");

    function setNativeValue(element, value) {
      if (!element) return;
      const valueSetter = Object.getOwnPropertyDescriptor(element.__proto__, 'value').set;
      valueSetter.call(element, value);
      element.dispatchEvent(new Event('input', { bubbles: true }));
      element.dispatchEvent(new Event('change', { bubbles: true }));
      element.dispatchEvent(new Event('keyup', { bubbles: true }));
      element.dispatchEvent(new Event('blur', { bubbles: true }));
    }

    if (uField && pField) {
      uField.focus();
      setNativeValue(uField, \"${widget.username}\");
      pField.focus();
      setNativeValue(pField, \"${widget.password}\");
      pField.blur();

      if (loginButton) {
        loginButton.click();
      }
    }

    // 20秒経過したら止める
    if (Date.now() - start > 20000) {
      clearInterval(interval);
    }
  }, 1000);
})();
""";
                  try {
                    await controller.runJavaScript(script);
                  } catch (e) {
                    print("JavaScript実行エラー（Dart側）: $e");
                    if (mounted)
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('自動入力エラー: $e')));
                  } finally {
                    if (mounted) setState(() => _isAutoFilling = false);
                  }
                }
              },
              onWebResourceError: (WebResourceError error) {
                if (mounted) {
                  setState(() {
                    _isLoadingPage = false;
                    _isAutoFilling = false;
                    _scriptExecutedForThisPageInstance = true;
                  });
                }
                print(
                  "WebResourceError: code=${error.errorCode} type=${error.errorType} description=${error.description} url=${error.url} isForMainFrame=${error.isForMainFrame}",
                );
                if (mounted && (error.isForMainFrame ?? false)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ページ読み込みエラー: ${error.description}')),
                  );
                }
              },
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          );

    Uri? initialUriToLoad = Uri.tryParse(widget.url);
    if (initialUriToLoad != null && initialUriToLoad.isAbsolute) {
      controller.loadRequest(initialUriToLoad);
    } else {
      controller.loadHtmlString(
        '<html><body><h1>無効なURL: ${widget.url}</h1></body></html>',
      );
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('URLが無効です')));
      if (mounted)
        setState(() {
          _isLoadingPage = false;
          _isAutoFilling = false;
          _scriptExecutedForThisPageInstance = true;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isLoadingPage || _isAutoFilling)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
            ),
        ],
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
          // WebView
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
