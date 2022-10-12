import 'package:cooking_stack/common/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
              const TextField(
                maxLength: 320,
                decoration: InputDecoration(
                    hintText: 'Correo Electrónico', counterText: ''),
              ),
              const TextField(
                obscureText: true,
                maxLength: 256,
                decoration:
                    InputDecoration(hintText: 'Contraseña', counterText: ''),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Iniciar Sesión')),
              )
            ]),
      ),
    );
  }
}
