import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

import '../common/global_variables.dart';

DateTime now = DateTime.now();
DateTime todaydate = DateTime(now.year, now.month, now.day);
DateTime tomorrowdate = DateTime(now.year, now.month, now.day + 1);

class CurrentOrders extends StatelessWidget {
  const CurrentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('created', isGreaterThanOrEqualTo: todaydate)
        .where('created', isLessThan: tomorrowdate)
        .orderBy('created', descending: true)
        .snapshots();

    return Scaffold(
        appBar: GlobalVar.asd,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: ordersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Algo ha salido mal 😞'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Cargando... 😽"));
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child:
                        Center(child: Text("No haz hecho ningún pedido 😞")));
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  List<dynamic> products = data['products'] as List<dynamic>;

                  String totalProductos = '';

                  for (int i = 0; i < products.length; i++) {
                    if (i < products.length - 1) {
                      totalProductos += products[i]['name'] + ', ';
                    } else {
                      totalProductos += products[i]['name'];
                    }
                  }

                  if (totalProductos.length > 20) {
                    totalProductos = '${totalProductos.substring(0, 20)}...';
                  }

                  DateTime date = data['created'].toDate();

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cliente: ${data['clientname']}'),
                            Text(
                                'Estado: ${data['satus'] == null ? 'En preparación ${TimeElapsed.fromDateTime(date)}' : data['satus'] == 1 ? 'Finalizado' : 'Cancelado'}'),
                          ],
                        ),
                        leading: Icon(
                          data['satus'] == null
                              ? Icons.access_time
                              : data['satus'] == 1
                                  ? Icons.done
                                  : Icons.cancel_outlined,
                          color: GlobalVar.black,
                          size: 50,
                        ),
                        subtitle: Text('Productos: $totalProductos'),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}
