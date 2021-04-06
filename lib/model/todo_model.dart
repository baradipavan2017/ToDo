class Task {
  int id;
  String title;
  DateTime date;
  String priority;

  Task([
    this.id,
    this.title,
    this.date,
    this.priority,
  ]);
  Task.withId([
    this.id,
    this.title,
    this.date,
    this.priority,
  ]);

  //CONVERTING OJECTS TO MAP
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    return map;
  }

  //EXTRACTING OBJECTS
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      map['id'],
      map['title'],
      DateTime.parse(map['date']),
      map['priority'],
    );
  }
}
