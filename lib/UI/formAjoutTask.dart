import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/model/task.dart';
import 'package:td2/viewModel/taskViewModel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormAjoutTask extends StatefulWidget {
    const FormAjoutTask({super.key});

    @override
    State<FormAjoutTask> createState() => _FormAjoutTaskState();
}

class _FormAjoutTaskState extends State<FormAjoutTask> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController textTitleController = TextEditingController();
    final TextEditingController textDescriptionController = TextEditingController();

    int _currentDifficulty = 1;

    @override dispose() {
        textTitleController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    TextFormField(
                        controller: textTitleController,
                        decoration: const InputDecoration(hintText: 'Nom'),
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return 'Veuillez insérer du texte';
                            }
                            return null;
                        },
                    ),
                    TextFormField(
                        controller: textDescriptionController,
                        decoration: const InputDecoration(hintText: 'Description'),
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez insérer du texte';
                            }
                            return null;
                        },
                    ),
                    FormBuilderSlider(
                        name: "Difficulté",
                        min: 1,
                        max: 5,
                        divisions: 4,
                        initialValue: 1,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _currentDifficulty = val.round();
                            });
                          }
                        },
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                                backgroundColor: Colors.lightBlue,
                            ),
                            onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Tâche créée')),
                                    );
                                    context.read<TaskViewModel>().addTask(
                                        Task.newTaskTitle(textTitleController.text,
                                        0,
                                        _currentDifficulty,
                                        textDescriptionController.text,
                                        ),
                                    );
                                    Navigator.pop(context);
                                }
                            },
                            child: const Text('Add Task'),
                        ),
                    ),
                ],
            ),
        );
    }
}