//     CookingStack - A semi-automated WhatsApp notificator for cooking orders
//     Copyright (C) 2023 theRightHoopRod

//     This program is free software: you can redistribute it and/or modify
//     it under the terms of the GNU Affero General Public License as published
//     by the Free Software Foundation, either version 3 of the License.

//     This program is distributed in the hope that it will be useful,
//     but WITHOUT ANY WARRANTY; without even the implied warranty of
//     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//     GNU Affero General Public License for more details.

//     You should have received a copy of the GNU Affero General Public License
//     along with this program.  If not, see <https://www.gnu.org/licenses/>.

//     Contact me at: https://github.com/theRightHooprod or hoop3.1416@gmail.com

import 'package:cooking_stack/views/admin_view.dart';
import 'package:cooking_stack/views/kitchen_view.dart';
import 'package:cooking_stack/views/login.dart';
import 'package:cooking_stack/views/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/custom_wa.dart';
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

  CustomWa.init();

  runApp(StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          switch (snapshot.data?.uid) {
            case null:
              return MaterialApp(
                  theme: CustomTheme.theme,
                  initialRoute: 'login',
                  routes: {
                    '/': (context) => const MainMenu(),
                    'admin': (context) => const Admin(),
                    'login': (context) => const LoginView(),
                    'kitchen': (context) => const KitchenView()
                  });
              ;
            default:
              return MaterialApp(
                  theme: CustomTheme.theme,
                  initialRoute: snapshot.data == null
                      ? 'login'
                      : snapshot.data!.uid == '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                          ? 'admin'
                          : snapshot.data!.uid == 'oBtMtP8gWXZfWWJlJEzHeIvoVMx2'
                              ? 'kitchen'
                              : '/',
                  routes: {
                    '/': (context) => const MainMenu(),
                    'admin': (context) => const Admin(),
                    'login': (context) => const LoginView(),
                    'kitchen': (context) => const KitchenView()
                  });
          }
      }
    },
  ));
}
