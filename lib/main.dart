import 'package:flutter/material.dart';
import 'package:github_search_users/Functions/services.dart';
import 'package:provider/provider.dart';
import 'Functions/change_theme.dart';
import 'Screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => ChangeTheme()),
        ChangeNotifierProvider(create:(context) => ServicesApi()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: Provider.of<ChangeTheme>(context).themeMode? ThemeMode.light:ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
