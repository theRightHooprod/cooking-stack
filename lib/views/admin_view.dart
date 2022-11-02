import 'dart:io';

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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddFood()),
              );
            },
            child: const Icon(Icons.add)),
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
              height: 200,
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
        height: 200,
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
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Nombre del alimento/producto',
                  icon: Icon(Icons.abc)),
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Precio', icon: Icon(Icons.attach_money)),
            ),
          ]),
    );
  }
}
