import 'package:cooking_stack/common/theme_data.dart';
import 'package:cooking_stack/views/login.dart';
import 'package:flutter/material.dart';

import 'common/global_variables.dart';
import 'views/admin_view.dart';
import 'views/order_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var controller = TextEditingController();
  var controller2 = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> col = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    List<String> labels = [
      'Agregar Pedido',
      'Pedidos Actuales',
      'Configuración',
      'Admin',
    ];

    const List<Icon> icons = [
      Icon(Icons.add),
      Icon(Icons.list),
      Icon(Icons.settings),
      Icon(Icons.person),
    ];

    return MaterialApp(
      theme: CustomTheme.theme,
      home: Scaffold(
          appBar: GlobalVar.asd,
          body: ListView.builder(
              itemCount: col.length,
              itemBuilder: (context, index) {
                return TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                        fixedSize: MaterialStateProperty.all(Size(
                            0,
                            (MediaQuery.of(context).size.height -
                                    (MediaQuery.of(context).padding.top +
                                        kToolbarHeight)) /
                                col.length)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => col[index])),
                    onPressed: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddOrder()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CurrentOrders()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Admin()),
                          );
                          break;
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[index].icon,
                          color: GlobalVar.black,
                          size: 30,
                        ),
                        Text(
                          labels[index],
                          style:
                              TextStyle(fontSize: 20, color: GlobalVar.black),
                        )
                      ],
                    ));
              })),
    );
  }
}
