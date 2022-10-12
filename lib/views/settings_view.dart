import 'package:flutter/material.dart';

import '../common/global_variables.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVar.asd,
      body: const Center(
        child: Text('Configuración'),
      ),
    );
  }
}
