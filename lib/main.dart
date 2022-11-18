import 'package:cooking_stack/views/admin_view.dart';
import 'package:cooking_stack/views/kitchen_view.dart';
import 'package:cooking_stack/views/login.dart';
import 'package:cooking_stack/views/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/theme_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    runApp(MaterialApp(
        theme: CustomTheme.theme,
        initialRoute: user == null
            ? 'login'
            : user.uid == '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? 'admin'
                : user.uid == 'oBtMtP8gWXZfWWJlJEzHeIvoVMx2'
                    ? 'kitchen'
                    : '/',
        routes: {
          '/': (context) => const MainMenu(),
          'admin': (context) => const Admin(),
          'login': (context) => const LoginView(),
          'kitchen': (context) => const KitchenView()
        }));
  });
}
