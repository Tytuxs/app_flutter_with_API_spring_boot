import 'package:flutter/material.dart';

import 'link/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*late StreamSubscription<User?> con;*/
  final _key = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    /*con = FirebaseAuth.instance.authStateChanges().listen((event) {
      _key.currentState?.pushNamed(event == null
          ? kLoginRoute
          : kHomeRoute);
    });*/
    _key.currentState?.pushNamed(pathHome);
  }

  @override
  void dispose () {
    /*con.cancel();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      /*future: Firebase.initializeApp(),*/
        builder: (context, snapshot) {
          return MaterialApp(
            navigatorKey: _key,
            debugShowCheckedModeBanner: false,
            initialRoute: pathHome,/*FirebaseAuth.instance.currentUser == null
                ? kLoginRoute
                : kHomeRoute,*/
            routes: router,
          );
        }
    );
  }
}
