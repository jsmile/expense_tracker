import 'package:flutter/material.dart';

import 'expenses/expenses.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true),  // 최신 버전에서는 기본값이 true
      home: Expenses(),
    );
  }
}
