import 'package:flutter/material.dart';

import 'expenses/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true).copyWith(
        // useMaterial3: true,  deprecated
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer, // appbar 배경색
          foregroundColor: kColorScheme.onPrimaryContainer, // appbar title 색상
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer, // card 배경색
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 5.0,
          ),
        ),
        // no ElevatedButtonThemeData() 에는 .copyWith() 가 없음.
        // elevatedButtonTheme: ElevatedButtonThemeData().copyWith(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                // color: Colors.red, // forgroundColor 가 아닌 곳에서만 적용됨.
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        // 아래와 같은 형식으로도 가능
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: ThemeData().textTheme.titleLarge!.copyWith(
        //             color: kColorScheme.secondaryContainer,
        //             fontSize: 20.0,
        //             fontWeight: FontWeight.bold,
        //           ),
        //     ),
      ), // 최신 버전에서는 기본값이 true
      home: const Expenses(),
    );
  }
}
