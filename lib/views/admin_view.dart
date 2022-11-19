import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_stack/common/firebase.dart';
import 'package:cooking_stack/views/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import 'package:image_picker/image_picker.dart';

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
        body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Algo ha salido mal 😞'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Cargando... 😽"));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text('Contiene: ${data['properties'].toString()}'),
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
                                        style:
                                            TextStyle(color: GlobalVar.black),
                                      ),
                                      backgroundColor: Colors.green,
                                    )),
                                  })
                              .catchError((error) => {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Producto agregado con exito')))
                                  });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
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

  var productName = TextEditingController();
  var productPrice = TextEditingController();
  var currentDescription = TextEditingController();

  @override
  dispose() {
    productName.dispose();
    productPrice.dispose();
    currentDescription.dispose();
    capturedImage = null;
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
                      imageQuality: 1);
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
            Text(
              'Añade una descripción (${descriptionsBankStrings.length})',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
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
                    .toList()),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: currentDescription,
                    decoration: InputDecoration(
                        hintText: 'Escribe una descripción',
                        icon:
                            Icon(Icons.list_outlined, color: GlobalVar.orange)),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      setState(() {
                        descriptionsBankStrings.add(currentDescription.text);
                      });
                    },
                    icon: Icon(Icons.add, color: GlobalVar.orange)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (productName.text.isNotEmpty &&
                      productPrice.text.isNotEmpty &&
                      capturedImage != null) {
                    Uint8List bytes =
                        File(capturedImage!.path).readAsBytesSync();

                    MyFirebase.addMiscellaneous(
                        name: productName.text,
                        price: double.parse(productPrice.text),
                        picture: base64Encode(bytes).length < 1048487
                            ? base64Encode(bytes)
                            : ' ',
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
