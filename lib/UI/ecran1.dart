import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/taskViewModel.dart';
import 'detail.dart';
import 'formTask.dart';

class ScreenOne extends StatelessWidget{

  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        final tasks = taskViewModel.liste;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];
            return Card(
              color: Colors.black26,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Text(tasks[index].id.toString())
                ),
                title: Text(tasks[index].title),
                subtitle: Text(tasks[index].description),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => FormTask(task: task),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          taskViewModel.deleteTask(task);
                        },
                      ),
                    ],
                  )
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => Detail(task: task),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}