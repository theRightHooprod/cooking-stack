import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/global_variables.dart';
import '../common/utils.dart';

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
                                builder: (context) => ExpandOrder(data: data)),
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

class ExpandOrder extends StatelessWidget {
  final Map<String, dynamic> data;

  const ExpandOrder({super.key, required this.data});

  Future<void> launchWhatsApp(String number) async {
    if (!await launchUrl(Uri.parse('https://wa.me/$number'))) {
      throw 'Could not launch whatsapp';
    }
  }

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
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data['whatsappnumber'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.message,
                  color: Colors.green,
                )
              ],
            ),
            onTap: () => launchWhatsApp(data['whatsappnumber']),
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
        ],
      ),
    );
  }
}
