import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task.dart';

class TaskViewModel extends ChangeNotifier{
  late List<Task> liste;
  Database database;
  TaskViewModel(Database database){
    database=database;
    liste=[];
  }
  Future<void> addTask(Task task) async{
    liste.add(task);
    await database.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO task(title, description, nbhours, difficulty) VALUES(?, ?, ?, ?)',
          ['${task.title}','${task.description}',"${task.nbhours}","${task.difficulty}"]
      );
      print('ajouté: $id');
    }
    );
    notifyListeners();
  }
  void generateTasks(){
    liste = Task.generateTask(50);
    notifyListeners();
  }
}