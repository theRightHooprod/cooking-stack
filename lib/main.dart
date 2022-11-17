import 'package:cooking_stack/views/admin_view.dart';
import 'package:cooking_stack/views/login.dart';
import 'package:cooking_stack/views/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'common/theme_data.dart';
import 'firebase_options.dart';

Widget accountZzz(String uid) {
  if (uid == '1OxEdNtRtkedc0aDHvhMgtyjfwx1') {
    return MaterialApp(
      theme: CustomTheme.theme,
      home: const Admin(),
    );
  } else if (uid == 'oBtMtP8gWXZfWWJlJEzHeIvoVMx2') {
    return MaterialApp(
      theme: CustomTheme.theme,
      initialRoute: '/',
      routes: {'/': (context) => const MainMenu()},
    );
  } else {
    return MaterialApp(
      theme: CustomTheme.theme,
      initialRoute: '/',
      routes: {'/': (context) => const MainMenu()},
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//   //Do not touch
//   FirebaseAuth.instance.authStateChanges().listen((User? user) async {
//     runApp(MaterialApp(
//       theme: CustomTheme.theme,
//       home: user == null
//           ? const LoginView()
//           : GlobalVar.accountAkinator(user.uid),
//     ));
//   });
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    runApp(user == null
        ? MaterialApp(theme: CustomTheme.theme, home: const LoginView())
        : accountZzz(user.uid));
  });
}
