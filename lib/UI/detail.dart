import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/task.dart';

class Detail extends StatelessWidget{
  final Task task;

  const Detail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${task.title} detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.blueGrey,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.key),
                title: const Text('Identifiant'),
                subtitle: Text('${task.id}'),
              ),
            ),
            Card(
              color: Colors.amberAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Description'),
                subtitle: Text('${task.description}'),
              ),
            ),
            Card(
              color: Colors.redAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.fireplace),
                title: const Text('Difficulté'),
                subtitle: Text('${task.difficulty}'),
              ),
            ),
            Card(
              color: Colors.lightBlueAccent,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.lock_clock),
                title: const Text("Nombre d'heures"),
                subtitle: Text('${task.nbhours}'),
              ),
            ),
            Card(
              color: Colors.green,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.tag),
                title: const Text("Les tags"),
                subtitle: Text(task.tags.toString()),
              ),
            ),
          ],
        )
      )
    );
  }

}