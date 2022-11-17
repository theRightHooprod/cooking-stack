import 'package:flutter/material.dart';

import '../common/global_variables.dart';

class pene extends StatelessWidget {
  const pene({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalVar.asd,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          children: const [
            TextField(
              decoration: InputDecoration(hintText: 'Nombre del cliente'),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(hintText: 'Teléfono del cliente'),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(hintText: 'Teléfono del cliente'),
            ),
          ],
        ));
  }
}

class CurrentOrders extends StatelessWidget {
  const CurrentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalVar.asd,
        body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: GlobalVar.orange, width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListTile(
                        trailing: Icon(
                          Icons.access_time,
                          color: GlobalVar.black,
                          size: 40,
                        ),
                        subtitle: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Orden: ',
                              style: TextStyle(
                                  color: GlobalVar.black, fontSize: 20)),
                          const TextSpan(
                              text: '#123456789',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20)),
                          const TextSpan(text: '\n'),
                          TextSpan(
                              text: 'Hora: ',
                              style: TextStyle(
                                  color: GlobalVar.black, fontSize: 20)),
                          const TextSpan(
                              text: '17:00',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20)),
                        ])))),
              );
            }));
  }
}
