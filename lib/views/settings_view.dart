import 'package:cooking_stack/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/global_variables.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String?> getWakey({required bool keyType}) async {
      final prefs = await SharedPreferences.getInstance();
      if (keyType) {
        return prefs.getString('wkey');
      } else {
        return prefs.getString('numberid');
      }
    }

    void saveWakey(String key) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wkey', key);
    }

    void saveNumberId(String key) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('numberid', key);
    }

    return Scaffold(
      appBar: GlobalVar.asd,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? const Text('Configuración de WhatsApp',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ))
                : const SizedBox(),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? const SizedBox(height: 20)
                : const SizedBox(),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? FutureBuilder(
                    future: getWakey(keyType: true),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            TextField(
                              controller:
                                  TextEditingController(text: snapshot.data),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock)),
                              onChanged: (value) {
                                saveWakey(value);
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Token de WhatsApp API',
                              ),
                              onChanged: (value) {
                                saveWakey(value);
                              },
                            ),
                          ],
                        );
                      }
                    },
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? FutureBuilder(
                    future: getWakey(keyType: false),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            TextField(
                              controller:
                                  TextEditingController(text: snapshot.data),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock)),
                              onChanged: (value) {
                                saveWakey(value);
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Id del teléfono WhatsApp API',
                              ),
                              onChanged: (value) {
                                saveNumberId(value);
                              },
                            ),
                          ],
                        );
                      }
                    },
                  )
                : const SizedBox(),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? const SizedBox(height: 20)
                : const SizedBox(),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          await prefs.remove('wkey');
                          await prefs.remove('numberid');
                        },
                        child: const Text('Borrar llaves')),
                  )
                : const SizedBox(),
            FirebaseAuth.instance.currentUser!.uid ==
                    '1OxEdNtRtkedc0aDHvhMgtyjfwx1'
                ? const SizedBox(height: 20)
                : const SizedBox(),
            const Text(
              'Configuración de la cuenta',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10)),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    });
                  },
                  child: const Text('Cerrar sesión')),
            ),
          ],
        ),
      ),
    );
  }
}
