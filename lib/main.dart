import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/ui/common/loading_indicator.dart';
import 'package:music_recommendation/src/ui/common/no_connectivity.dart';
import 'package:music_recommendation/src/ui/homepage/home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        title: 'Musiemotion',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Lato",
        ),
        home: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return MusiemotionLoadingIndicator();
            } else if (snapshot.data == ConnectivityResult.none) {
              return ConnectivityErrorIndicator();
            } else {
              return HomePage();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
