import 'package:biruni_app/product/theme/biruni_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/provider/webpage_state.dart';
import 'features/auth/signin.dart';
import 'features/main/drawer_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerState()), // DrawerState için Provider
        ChangeNotifierProvider(create: (_) => WebPageState()), // WebPageState için Provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: BiruniAppTheme.defaultTheme,
      home: const SigninPage(),
    );
  }
}