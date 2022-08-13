class Entry {
  final String id;
  final String name;
  final String service;
  final bool completed;

  Entry({
    required this.id,
    required this.name,
    required this.service,
    required this.completed,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['_id'],
      name: json['name'],
      service: json['service'],
      completed: json['completed'],
    );
  }
}

class WaitlistDataModel {
  final String date;
  final List<Entry> entries;

  WaitlistDataModel({
    required this.date,
    required this.entries,
  });

  factory WaitlistDataModel.fromJson(Map<String, dynamic> json) {
    return WaitlistDataModel(
      date: json['date'],
      entries: json['entries'].map((v) => Entry.fromJson(v.toJson())).toList(),
    );
  }
}
