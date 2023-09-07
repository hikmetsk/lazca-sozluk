import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazca_sozluk/MainPage.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/bloc/brower_state.dart';
import 'package:lazca_sozluk/bloc/browser_bloc.dart';
import 'package:lazca_sozluk/config.dart';
import 'package:lazca_sozluk/firebase_options.dart';
import 'package:provider/provider.dart';

void main() {
  TextEditingController searchbarTextEditingController =
      TextEditingController();
  FocusNode searchbarFocusNode = FocusNode();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.green,
        debugShowCheckedModeBanner: false,
        title: 'Lazca Sözlük',
        theme: ThemeData(
            visualDensity: VisualDensity.standard,
            colorSchemeSeed: Colors.lightGreen,
            useMaterial3: true,
            fontFamily: "MNotoSans"),
        home: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) => BlocProvider(
            create: (_) => BrowserBloc(BrowserState()),
            child: ChangeNotifierProvider<SearchModel>(
              create: (context) => SearchModel(),
              child: const MainPage(),
            ),
          ),
        ));
  }
}
