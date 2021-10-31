import 'package:election_exit_poll_620710339/pages/home_page.dart';
import 'package:election_exit_poll_620710339/pages/solution_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        SolutionPage.routeName : (context) => const SolutionPage(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}