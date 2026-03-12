int nb = -1;

class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;

  Task(
    {required this.id,
    required this.title,
    required this.tags,
    required this.nbhours,
    required this.difficulty,
    required this.description}
  );

  static Task fromJson(Map<String, dynamic>json){
    return Task(
        id: json['id'],
        title: json['title'],
        tags: List<String>.from(json['tags'] as List),
        nbhours: json['nbhours'],
        difficulty: json['difficulty'],
        description: json['description']);
  }

  static List<Task> generateTask(int i){
    List<Task> tasks=[];
    for(int n=0;n<i;n++){
      tasks.add(Task(
        id: n,
        title: "title $n",
        tags: ['tag $n','tag${n+1}'],
        nbhours: n,
        difficulty: n,
        description: '$n'));
      ++nb;
    }
    return tasks;
  }
  factory Task.newTask(){
    nb++;
    return Task(
      id: nb,
      title: 'title $nb',
      tags: ['tags $nb'],
      nbhours: nb,
        difficulty: nb%5,
      description: 'description $nb'
    );
  }

  factory Task.newTaskTitle(String title, int nbhours, int difficulty, String description) {
    nb++;
    return Task(
      id: nb,
      title: title,
      tags: ['tags $nb'],
      nbhours: nbhours,
      difficulty: difficulty,
      description: description,
    );
  }

}
