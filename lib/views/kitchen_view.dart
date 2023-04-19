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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/common/custom_wa.dart';
import 'package:cooking_stack/common/global_variables.dart';
import 'package:cooking_stack/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

import '../common/local_notifications.dart';
import '../common/utils.dart';

DateTime now = DateTime.now();
DateTime todaydate = DateTime(now.year, now.month, now.day);
DateTime tomorrowdate = DateTime(now.year, now.month, now.day + 1);

class KitchenView extends StatefulWidget {
  const KitchenView({super.key});

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
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
        if (element.type == DocumentChangeType.added) {
          service.showNotification(
              id: 0, title: 'Cooking Stack', body: 'Se ha añadido una orden');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    notificationListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime todaydate = DateTime(now.year, now.month, now.day);
    DateTime tomorrowdate = DateTime(now.year, now.month, now.day + 1);

    final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('created', isGreaterThanOrEqualTo: todaydate)
        .where('created', isLessThan: tomorrowdate)
        .orderBy('created', descending: true)
        .snapshots();

    return Scaffold(
        appBar: GlobalVar.asd,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
            heroTag: null,
            child: const Icon(Icons.settings)),
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
                return Center(
                    child: CircularProgressIndicator(
                  color: GlobalVar.orange,
                ));
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
                  String clientname = data['clientname'];

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
                  if (clientname.length > 16) {
                    clientname = '${clientname.substring(0, 16)}...';
                  }

                  DateTime date = data['created'].toDate();

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KitchenExpandOrder(
                                      data: data,
                                      docid: document.id,
                                    )),
                          );
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cliente: $clientname'),
                            Text(
                                'Estado: ${data['status'] == null ? 'En preparación ${TimeElapsed.fromDateTime(date)}' : data['status'] == 1 ? 'Finalizado' : 'No posible'}'),
                          ],
                        ),
                        leading: Icon(
                          data['status'] == null
                              ? Icons.access_time
                              : data['status'] == 1
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

class KitchenExpandOrder extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docid;

  const KitchenExpandOrder(
      {super.key, required this.data, required this.docid});

  @override
  Widget build(BuildContext context) {
    List<dynamic> products = data['products'] as List<dynamic>;

    return Scaffold(
      appBar: GlobalVar.asd,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Productos ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(products[index]['name']),
                    subtitle: Text(
                        MyUtils.getSingleString(products[index]['properties'])),
                    trailing: Text('\$ ${products[index]['price']}'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Nombre del cliente',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            data['clientname'],
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'WhatsApp del cliente',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            data['whatsappnumber'],
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Precio Total',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '\$${data['totalprice']}',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Estado:',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            data['status'] == null
                ? 'En preparación'
                : data['status'] == 1
                    ? 'Finalizado'
                    : 'No posible',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: data['status'] == 1
                      ? null
                      : () {
                          FirebaseFirestore.instance
                              .collection('orders')
                              .doc(docid)
                              .update({'status': 1});
                          CustomWa.sendReady(int.parse(data['whatsappnumber']));
                          Navigator.pop(context);
                        },
                  child: const Text('Finalizado'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: data['status'] == 0
                      ? null
                      : () {
                          FirebaseFirestore.instance
                              .collection('orders')
                              .doc(docid)
                              .update({'status': 0});
                          CustomWa.sendNotPossible(
                              int.parse(data['whatsappnumber']));
                          Navigator.pop(context);
                        },
                  child: const Text('No posible'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
