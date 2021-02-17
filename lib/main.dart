import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shortener/components/home_controller.dart';

import 'package:url_shortener/pages/historicpage.dart';
import 'package:url_shortener/pages/homepage.dart';




void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<HomeController>(HomeController());
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
    home: IndexPage()),
  );
}

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomePage(title: 'Encurtador de URL'),
          HistoricPage(title: 'Histórico'),
        ],
      ),
    );
  }
}
