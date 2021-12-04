import 'dart:io';

import 'package:anime_news/pages/top_anime_page.dart';
import 'package:flutter/material.dart';

import 'my_http_overrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopAnimePage(tittle: "Jikan Moe App"),
    );
  }
}
