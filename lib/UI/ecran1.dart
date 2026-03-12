import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../viewModel/taskViewModel.dart';
import 'detail.dart';

class ScreenOne extends StatelessWidget{


  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    late List<Task> tasks;
    String tags='';
    tasks = context.watch<TaskViewModel>().liste;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index){
        return Card(
          color: Colors.black26,
          elevation: 7,
          margin: const EdgeInsets.all(10),
          child:ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: Text(tasks[index].id.toString())
            ),
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => Detail(task:tasks[index]),
                )
              );
            },
          )
        );
      }
    );
  }
}