import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task.dart';

class TaskViewModel extends ChangeNotifier {
  late List<Task> liste;
  Database database;

  TaskViewModel(this.database) {
    liste = [];
    loadTasks();
  }

  Task _taskFromMap(Map<String, dynamic> map, List<String> tags) {
    return Task(
      id: map['id'],
      title: map['title'],
      tags: tags,
      nbhours: map['nbhours'],
      difficulty: map['difficulty'],
      description: map['description'],
    );
  }

  Future<void> loadTasks() async {
    final List<Map<String, dynamic>> taskMaps = await database.rawQuery(
        'SELECT * FROM task');
    List<Task> result = [];
    for (var taskMap in taskMaps) {
      final List<Map<String, dynamic>> tagMaps = await database.rawQuery(
          'SELECT nom FROM tags WHERE task_id = ?', [taskMap['id']]
      );
      final tags = tagMaps.map((t) => t['nom'] as String).toList();
      result.add(_taskFromMap(taskMap, tags));
    }
    liste = result;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    try {
      int id = await database.rawInsert(
        'INSERT INTO task(title, nbhours, difficulty, description) VALUES(?, ?, ?, ?)',
        [task.title, task.nbhours, task.difficulty, task.description],
      );
      for (String tag in task.tags) {
        await database.rawInsert(
          'INSERT INTO tags(nom, task_id) VALUES(?, ?)',
          [tag, id],
        );
      }
      await loadTasks();
    } catch (e) {
      print('Erreur ajout : $e');
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await database.rawDelete('DELETE FROM task WHERE id = ?', [task.id]);
      await loadTasks();
    } catch (e) {
      print('Erreur suppression : $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await database.rawUpdate(
        'UPDATE task SET title = ?, nbhours = ?, difficulty = ?, description = ? WHERE id = ?',
        [task.title, task.nbhours, task.difficulty, task.description, task.id],
      );
      await database.rawDelete('DELETE FROM tags WHERE task_id = ?', [task.id]);
      for (String tag in task.tags) {
        await database.rawInsert(
          'INSERT INTO tags(nom, task_id) VALUES(?, ?)',
          [tag, task.id],
        );
      }
      await loadTasks();
    } catch (e) {
      print('Erreur mise à jour : $e');
    }
  }

  void generateTasks() {
    liste = Task.generateTask(50);
    notifyListeners();
  }
}