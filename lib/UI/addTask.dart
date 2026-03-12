import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'formAjoutTask.dart';

class AddTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Center(
        child: FormAjoutTask()
      ),
    ) ;
  }
}
