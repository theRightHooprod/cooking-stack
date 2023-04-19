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

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/common/firebase.dart';
import 'package:flutter/material.dart';

import '../common/custom_wa.dart';
import '../common/global_variables.dart';
import '../common/utils.dart';

class ShoopingCar extends StatefulWidget {
  const ShoopingCar({super.key});

  @override
  State<ShoopingCar> createState() => _ShoopingCarState();
}

class _ShoopingCarState extends State<ShoopingCar> {
  late List<Map<String, dynamic>> data = [];
  double totalprice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVar.asd,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 60),
                Text(
                  '\$$totalprice',
                  style: const TextStyle(fontSize: 30),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: data.isEmpty
                  ? Text(
                      'Comienza agregando productos 🥰',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data[index]['name']),
                              subtitle: Text(MyUtils.getSingleString(
                                  data[index]['properties'])),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('\$ ${data[index]['price']}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        if (totalprice != 0 &&
                                            data.isNotEmpty) {
                                          totalprice -= data[index]['price'];
                                        }
                                        data.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              appBar: GlobalVar.asd,
                                              body: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: ListView(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Nombre',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        title: Text(data[index]
                                                            ['name']),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Precio',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        title: Text(
                                                            '${data[index]['price']}'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Imagen',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    data[index]['picture'] != ''
                                                        ? Image.memory(
                                                            base64Decode(data[
                                                                    index]
                                                                ['picture']))
                                                        : const Icon(
                                                            Icons.cancel,
                                                            size: 40,
                                                            color: Colors.red,
                                                          ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      'Contiene',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: data[index]
                                                                ['properties']
                                                            .length,
                                                        itemBuilder:
                                                            (context, index2) {
                                                          return Card(
                                                            child: ListTile(
                                                              title: Text(data[
                                                                          index]
                                                                      [
                                                                      'properties']
                                                                  [index2]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )));
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5)),
                    backgroundColor:
                        MaterialStateProperty.all(GlobalVar.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  if (data.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOut(data: data)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Por favor, agrega almenos un articulo al carrito'),
                    ));
                  }
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final dataFromSecondPage = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddOrder()),
            ) as List<Map<String, dynamic>>;
            data += dataFromSecondPage;
            for (var i = 0; i < dataFromSecondPage.length; i++) {
              totalprice += dataFromSecondPage[i]['price'];
            }
            setState(() {});
          },
          child: const Icon(Icons.add)),
    );
  }
}

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> miscellaneousStream =
        FirebaseFirestore.instance.collection('miscellaneous').snapshots();

    List<Map<String, dynamic>> miscellaneousList = [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(miscellaneousList),
        ),
        centerTitle: true,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text(
            'Cooking Stack',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.fastfood_sharp,
            color: Colors.white,
            size: 25,
          )
        ]),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(miscellaneousList);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: miscellaneousStream,
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

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        onTap: () => miscellaneousList.add(data),
                        title: Text(data['name']),
                        subtitle: Text(
                            'Contiene: ${MyUtils.getSingleString(data['properties'])}'),
                        trailing: Text('\$ ${data['price']}'),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CheckOut extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const CheckOut({
    required this.data,
    super.key,
  });

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var clientNameController = TextEditingController();
  var clientWhatsAppController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    clientNameController.dispose();
    clientWhatsAppController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalprice = 0;

    return Scaffold(
        appBar: GlobalVar.asd,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Datos del cliente',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: clientNameController,
                decoration: InputDecoration(
                    hintText: 'Nombre del cliente',
                    icon: Icon(
                      Icons.person,
                      color: GlobalVar.orange,
                    )),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: clientWhatsAppController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'WhatsApp del cliente',
                    icon: Icon(
                      Icons.phone,
                      color: GlobalVar.orange,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Productos',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(widget.data[index]['name']),
                        subtitle: Text('${widget.data[index]['properties']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$ ${widget.data[index]['price']}'),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.data.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5)),
                      backgroundColor:
                          MaterialStateProperty.all(GlobalVar.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    if (clientNameController.text.isNotEmpty &&
                        clientWhatsAppController.text.isNotEmpty) {
                      for (var i = 0; i < widget.data.length; i++) {
                        totalprice += widget.data[i]['price'];
                      }
                      MyFirebase.addOrder(
                              order: CustomOrder(
                                  clientname: clientNameController.text
                                      .trimLeft()
                                      .trimRight(),
                                  products: widget.data,
                                  totalPrice: totalprice,
                                  whatsappNumber: clientWhatsAppController.text
                                      .trimLeft()
                                      .trimRight()
                                      .replaceAll(' ', '')))
                          .onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      }).then((value) => {
                                CustomWa.sendAdded(
                                    int.parse(clientWhatsAppController.text
                                        .trimLeft()
                                        .trimRight()
                                        .replaceAll(' ', '')),
                                    widget.data),
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'El pedido se ga agregado con exito',
                                    style: TextStyle(color: GlobalVar.black),
                                  ),
                                  backgroundColor: Colors.green,
                                )),
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName('/'),
                                ),
                              });
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Por favor rellena los datos del cliente'),
                      ));
                    }
                  },
                  child: const Text(
                    'Mandar a la cocina',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 20)
            ],
          ),
        ));
  }
}
