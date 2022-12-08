import 'package:cooking_stack/common/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
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
              TextField(
                controller: usernameController,
                maxLength: 320,
                decoration: const InputDecoration(
                    hintText: 'Correo Electrónico', counterText: ''),
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
                          email: usernameController.text.trimLeft().trimRight(),
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
