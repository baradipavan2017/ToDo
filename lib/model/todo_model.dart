class Task {
  int _id;
  String _title;
  DateTime _date;
  String _priority;

  Task([
    this._id,
    this._title,
    this._date,
    this._priority,
  ]);
  Task.withId([
    this._id,
    this._title,
    this._date,
    this._priority,
  ]);

  //CONVERTING OJECTS TO MAP
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['date'] = _date.toIso8601String();
    map['priority'] = _priority;
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
