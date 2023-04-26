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

import 'package:cooking_stack/common/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

const List<String> list = [
  'empleado@caffetec.com',
  'gerencia@caffetec.com',
  'cocina@caffetec.com'
];

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  String dropdownValue = list.first;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.modulate),
              image: AssetImage('assets/pattern.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalVar.asd,
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/caffetec-logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text('CaffeTec',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: GlobalVar.orange)),
              const SizedBox(height: 20),
              Text('Introduce tu cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: GlobalVar.black,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              GlobalVar.isProd
                  ? TextField(
                      controller: usernameController,
                      maxLength: 320,
                      enabled: GlobalVar.isProd,
                      decoration: const InputDecoration(
                          hintText: 'Correo Electrónico', counterText: ''),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: DropdownButton(
                        padding: const EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(50),
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: Theme.of(context).textTheme.titleMedium,
                        value: dropdownValue,
                        items: list.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        focusColor: Colors.transparent,
                      ),
                    ),
              TextField(
                controller: passwordController,
                obscureText: true,
                maxLength: 256,
                decoration: const InputDecoration(
                    hintText: 'Contraseña', counterText: ''),
              ),
              const SizedBox(height: 20),
              RoundedLoadingButton(
                controller: _btnController,
                color: GlobalVar.orange,
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: GlobalVar.isProd
                              ? usernameController.text.trimLeft().trimRight()
                              : dropdownValue,
                          password: passwordController.text)
                      .then((value) {
                    _btnController.success();
                    Future.delayed(
                        const Duration(seconds: 1, milliseconds: 500),
                        () => Navigator.pushReplacementNamed(
                              context,
                              GlobalVar.accountAkinator(value.user!.uid),
                            ));
                  }).onError((error, stackTrace) {
                    _btnController.error();

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  });
                  Future.delayed(
                      const Duration(seconds: 2), () => _btnController.reset());
                },
                child: const Text('Iniciar sesión'),
              ),
            ]),
      ),
    );
  }
}
