import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/model/task.dart';
import 'package:td2/viewModel/taskViewModel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'

class FormAjoutTask extends StatefulWidget {
    const FormAjoutTask({super.key});

    @override
    State<FormAjoutTask> createState() => _FormAjoutTaskState();
}

class _FormAjoutTaskState extends State<FormAjoutTask> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController textTitleController = TextEditingController();

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
                    FormBuilderSlider(
                        min: 1,
                        max: 5,
                        divisions: 4,
                        value: 1,
                        label; 'Difficulté',
                        onChanged: (val) => setState(() => value = val.round()),
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
                                    context.read<TaskViewModel>().addTask(Task.newTaskTitle(textTitleController.text));
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