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
        difficulty: 1,
        description: '$n'));
      ++nb;
    }
    return tasks;
  }

  String tagsToString() {
    var stringTags = "";
    for (var i = 0; i < tags.length; i++) {
      if (i == tags.length - 1) {
        stringTags += tags[i];
      } else {
        stringTags += tags[i] + ",";
      }
    }
    return stringTags;
  }

  factory Task.newTask(String title, int nbhours, int difficulty, String description, List<String> tags) {
    nb++;
    return Task(
      id: nb,
      title: title,
      tags: tags,
      nbhours: nbhours,
      difficulty: difficulty,
      description: description,
    );
  }
}
