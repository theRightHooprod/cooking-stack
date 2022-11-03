import 'dart:convert';
import 'dart:io';

import 'package:cooking_stack/common/firebase.dart';
import 'package:cooking_stack/views/settings_view.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';
import 'package:image_picker/image_picker.dart';

class Admin extends StatelessWidget {
  const Admin({
    super.key,
  });

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
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                heroTag: null,
                child: const Icon(Icons.settings)),
          ],
        ),
        body: const Center(child: Text('Hola admin')));
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
    super.dispose();
  }

  Future<Container> previewImage() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
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
    if (response.files != null) {
      capturedImage = response.files!.first;
      setState(() {});
      return Container(
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
    } else {
      throw Error();
    }
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
                      source: ImageSource.camera, requestFullMetadata: false);
                  setState(() {});
                }),
                child: FutureBuilder(
                  future: previewImage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )),
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
                                descriptionsBankStrings.removeLast();
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
                    final bytes = File(capturedImage!.path).readAsBytesSync();

                    MyFirebase.addMiscellaneous(
                        name: productName.text,
                        price: int.parse(productPrice.text),
                        picture: base64Encode(bytes),
                        description: descriptionsBankStrings);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Producto agregado con exito'),
                    ));
                  }
                },
                child: const Text('Agregar'))
          ]),
    );
  }
}
