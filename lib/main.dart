import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'Pages/SplashScreen.dart';
import 'package:file_manager_abdulelah_alsbiei/Theme/colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ColorsLists(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folder Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

