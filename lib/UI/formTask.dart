import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/model/task.dart';
import 'package:td2/viewModel/taskViewModel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormTask extends StatefulWidget {
  final Task? task;

  const FormTask({super.key, this.task});

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textTitleController;
  late TextEditingController textDescriptionController;
  late TextEditingController textNbHoursController;
  late TextEditingController textTagsController;
  late int _currentDifficulty;

  @override
  void initState() {
    super.initState();
    textTitleController = TextEditingController(text: widget.task?.title ?? '');
    textDescriptionController = TextEditingController(text: widget.task?.description ?? '');
    textNbHoursController = TextEditingController(text: widget.task?.nbhours.toString() ?? '');
    textTagsController = TextEditingController(text: widget.task?.tagsToString() ?? '');
    _currentDifficulty = widget.task?.difficulty ?? 1;
  }

  @override
  dispose() {
    textTitleController.dispose();
    textDescriptionController.dispose();
    textNbHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editer la tâche' : 'Ajouter une tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                key: ValueKey(_currentDifficulty),
                name: "Difficulté",
                min: 1,
                max: 5,
                divisions: 4,
                initialValue: _currentDifficulty.toDouble().clamp(1, 5),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _currentDifficulty = val.round();
                    });
                  }
                },
              ),
              TextFormField(
                controller: textNbHoursController,
                decoration: const InputDecoration(hintText: "Nombre d'heures"),
                validator: (String? value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return "Veuillez insérer un nombre d'heures";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: textTagsController,
                decoration: const InputDecoration(hintText: 'Tags (Ces tags doivent être séparés par des virgules)'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez insérer du texte';
                  }
                  return null;
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
                        SnackBar(content: Text(isEditing ? 'Tâche modifiée' : 'Tâche créée')),
                      );

                      final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

                      if (isEditing) {
                        taskViewModel.updateTask(
                          Task(
                            id: widget.task!.id,
                            title: textTitleController.text,
                            description: textDescriptionController.text,
                            nbhours: int.parse(textNbHoursController.text),
                            difficulty: _currentDifficulty,
                            tags: textTagsController.text.split(','),
                          ),
                        );
                      } else {
                        taskViewModel.addTask(
                          Task.newTask(
                            textTitleController.text,
                            int.parse(textNbHoursController.text),
                            _currentDifficulty,
                            textDescriptionController.text,
                            textTagsController.text.split(','),
                          ),
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? 'Modifier' : 'Ajouter'),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}