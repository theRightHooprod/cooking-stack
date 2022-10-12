import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';

import '../common/global_variables.dart';

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
                MaterialPageRoute(builder: (context) => const AddWidget()),
              );
            },
            child: const Icon(Icons.add)),
        body: const Center(child: Text('Hola admin')));
  }
}

class AddWidget extends StatelessWidget {
  const AddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVar.asd,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            GestureDetector(
              onTap: (() {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('*Mostrando camara 📷*')));
              }),
              child: Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      border: Border.all(color: GlobalVar.orange, width: 4),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 50,
                  )),
            ),
            const SizedBox(height: 10.0),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Categoría', icon: Icon(Icons.category)),
            ),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Precio', icon: Icon(Icons.attach_money)),
            ),
            // Specify the generic type of the data in the list.
            // Expanded(
            //   child: ImplicitlyAnimatedList(
            //     // The current items in the list.
            //     items: const ['Hola', 'Ejemplo', 'Mundo'],
            //     // Called by the DiffUtil to decide whether two object represent the same item.
            //     // For example, if your items have unique ids, this method should check their id equality.
            //     areItemsTheSame: (a, b) => a == b,
            //     // Called, as needed, to build list item widgets.
            //     // List items are only built when they're scrolled into view.
            //     itemBuilder: (context, animation, item, index) {
            //       // Specifiy a transition to be used by the ImplicitlyAnimatedList.
            //       // See the Transitions section on how to import this transition.
            //       return SizeFadeTransition(
            //         sizeFraction: 0.7,
            //         curve: Curves.easeInOut,
            //         animation: animation,
            //         child: Text(item),
            //       );
            //     },
            //     // An optional builder when an item was removed from the list.
            //     // If not specified, the List uses the itemBuilder with
            //     // the animation reversed.
            //     removeItemBuilder: (context, animation, oldItem) {
            //       return FadeTransition(
            //         opacity: animation,
            //         child: Text(oldItem),
            //       );
            //     },
            //   ),
            // )
          ]),
    );
  }
}
