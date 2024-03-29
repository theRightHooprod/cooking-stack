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
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/common/firebase.dart';
import 'package:cooking_stack/views/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';

import '../common/global_variables.dart';

class Admin extends StatefulWidget {
  const Admin({
    super.key,
  });

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('miscellaneous').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalVar.asd,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFood()),
                  );
                },
                heroTag: null,
                child: const Icon(Icons.add)),
            const SizedBox(height: 10),
            FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()),
                  );
                },
                heroTag: null,
                child: const Icon(Icons.settings)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: _usersStream,
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
                  String totalProperties = '';
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  int cantidad =
                      data['cantidad'] != null ? data['cantidad'] as int : 0;

                  List<dynamic> propierties =
                      data['properties'] as List<dynamic>;

                  for (int i = 0; i < propierties.length; i++) {
                    if (i < propierties.length - 1) {
                      totalProperties += propierties[i] + ', ';
                    } else {
                      totalProperties += propierties[i];
                    }
                  }

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: cantidad == 0
                            ? Text('Contiene: $totalProperties')
                            : Text('En inventario: $cantidad'),
                        leading: data['picture'] != ''
                            ? Image.memory(base64Decode(data['picture']))
                            : const Icon(
                                Icons.cancel,
                                size: 40,
                                color: Colors.red,
                              ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$ ${data['price']}'),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('miscellaneous')
                                    .doc(document.id)
                                    .delete()
                                    .then((value) => {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar(),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              'El producto se ha eliminado correctamente',
                                              style: TextStyle(
                                                  color: GlobalVar.black),
                                            ),
                                            backgroundColor: Colors.green,
                                          )),
                                        })
                                    .catchError((error) => {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar(),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Producto agregado con exito')))
                                        });
                              },
                            ),
                          ],
                        ),
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

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final ImagePicker _picker = ImagePicker();
  XFile? capturedImage;
  List<Widget> descriptionsBank = [];
  List<String> descriptionsBankStrings = [];
  int savedIndex = 0;
  bool invetoryToggle = false;
  int onInvetory = 0;

  var productName = TextEditingController();
  var productPrice = TextEditingController();
  var currentDescription = TextEditingController();

  @override
  dispose() {
    productName.dispose();
    productPrice.dispose();
    currentDescription.dispose();
    // capturedImage = null;
    super.dispose();
  }

  Future<XFile> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (!response.isEmpty && response.file != null) {
      return response.files!.first;
    } else {
      return capturedImage!;
    }
  }

  Container previewImage() {
    return capturedImage == null
        ? Container(
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                border: Border.all(color: GlobalVar.orange, width: 4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                )),
            child: const Icon(
              Icons.camera_alt,
              size: 50,
            ))
        : Container(
            height: 175,
            decoration: BoxDecoration(
                border: Border.all(color: GlobalVar.orange, width: 4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  image: FileImage(File(capturedImage!.path)),
                  fit: BoxFit.fitWidth,
                )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVar.asd,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            GestureDetector(
                onTap: (() async {
                  capturedImage = await _picker.pickImage(
                      source: ImageSource.camera,
                      requestFullMetadata: false,
                      imageQuality: 50);
                  setState(() {});
                }),
                child:
                    !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder(
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.done:
                                  return previewImage();
                                default:
                                  return const Center(
                                      child: CircularProgressIndicator());
                              }
                            },
                          )
                        : previewImage()),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Propiedades',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: productName,
              decoration: InputDecoration(
                  hintText: 'Nombre del alimento/producto',
                  icon: Icon(Icons.abc, color: GlobalVar.orange)),
            ),
            TextField(
              controller: productPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Precio',
                  icon: Icon(Icons.attach_money, color: GlobalVar.orange)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '¿Inventariado?',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                FlutterSwitch(
                  width: 80,
                  height: 25,
                  toggleSize: 25,
                  value: invetoryToggle,
                  borderRadius: 30,
                  padding: 8.0,
                  activeColor: GlobalVar.orange,
                  onToggle: (val) {
                    setState(() {
                      invetoryToggle = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            invetoryToggle
                ? const Text(
                    'Cantidad en inventario',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  )
                : const SizedBox(),
            invetoryToggle
                ? const SizedBox(
                    height: 20,
                  )
                : const SizedBox(),
            invetoryToggle
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: GlobalVar.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (onInvetory > 0) {
                              onInvetory--;
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        onInvetory.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: GlobalVar.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            onInvetory++;
                          });
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
            !invetoryToggle
                ? Text(
                    'Descripción del producto (${descriptionsBankStrings.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  )
                : const SizedBox(),
            !invetoryToggle
                ? const SizedBox(
                    height: 20,
                  )
                : const SizedBox(),
            !invetoryToggle
                ? Column(
                    children: descriptionsBank = descriptionsBankStrings
                        .map(
                          (description) => ListTile(
                            leading: const Icon(
                              Icons.arrow_forward_outlined,
                            ),
                            title: Text(description),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    descriptionsBankStrings.removeWhere(
                                        (element) => element == description);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                )),
                          ),
                        )
                        .toList())
                : const SizedBox(),
            !invetoryToggle
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: currentDescription,
                          decoration: InputDecoration(
                              hintText: 'Escribe una descripción',
                              icon: Icon(Icons.list_outlined,
                                  color: GlobalVar.orange)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (!descriptionsBankStrings
                                  .contains(currentDescription.text)) {
                                descriptionsBankStrings
                                    .add(currentDescription.text);
                              }
                              currentDescription.clear();
                            });
                          },
                          icon: Icon(Icons.add, color: GlobalVar.orange)),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (productName.text.isNotEmpty &&
                      productPrice.text.isNotEmpty) {
                    // Uint8List bytes =
                    //     File(capturedImage!.path).readAsBytesSync();

                    MyFirebase.addMiscellaneous(
                        isInventoried: invetoryToggle,
                        cantidad: onInvetory,
                        name: productName.text,
                        price: double.parse(productPrice.text),
                        picture: '',
                        description: descriptionsBankStrings);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Producto agregado con exito'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('El nombre, precio y foto son obligatorios'),
                    ));
                  }
                },
                child: const Text('Agregar'))
          ]),
    );
  }
}
