import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/views/settings_view.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import '../common/local_notifications.dart';
import 'add_order.dart';
import 'order_view.dart';

DateTime now = DateTime.now();
DateTime todaydate = DateTime(now.year, now.month, now.day);
DateTime tomorrowdate = DateTime(now.year, now.month, now.day + 1);

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var controller = TextEditingController();
  var controller2 = TextEditingController();

  dynamic notificationListener;

  @override
  void initState() {
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();

    notificationListener = FirebaseFirestore.instance
        .collection('orders')
        .where('created', isGreaterThanOrEqualTo: todaydate)
        .where('created', isLessThan: tomorrowdate)
        .orderBy('created', descending: true)
        .snapshots()
        .listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.modified) {
          service.showNotification(
              id: 0,
              title: 'Cooking Stack',
              body: 'Se ha modificado el estado de una orden');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    notificationListener.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> col = [
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    List<String> labels = [
      'Agregar Pedido',
      'Pedidos Actuales',
      'Configuración',
    ];

    const List<Icon> icons = [
      Icon(Icons.add),
      Icon(Icons.list),
      Icon(Icons.settings),
    ];

    return Scaffold(
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
                              builder: (context) => const ShoopingCar()),
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
                              builder: (context) => const SettingsView()),
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
                        style: TextStyle(fontSize: 20, color: GlobalVar.black),
                      )
                    ],
                  ));
            }));
  }
}
