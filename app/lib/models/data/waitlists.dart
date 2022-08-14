import 'package:objectid/objectid.dart';

class Entry {
  int idx;
  final String? id;
  final String name;
  final String? service;
  bool? completed;

  Entry(
      {this.id,
      required this.idx,
      required this.name,
      required this.service,
      required this.completed});

  Map<String, dynamic> toJson() => {
        '_id': id ?? ObjectId().hexString,
        'idx': idx,
        'name': name,
        'service': service,
        'completed': completed,
      };

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['_id'] as String,
      idx: json['idx'] as int,
      name: json['name'] as String,
      service: json['service'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  void setIdx(int index) {
    idx = index;
  }

  void setCompleted(bool? status) {
    completed = status;
  }
}

class Waitlist {
  final String date;
  final List<Entry> entries;

  Waitlist({
    required this.date,
    required this.entries,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'entries': entries,
      };

  factory Waitlist.fromJson(Map<String, dynamic> json) {
    return Waitlist(
      date: json['date'] as String,
      entries: json['entries'].map<Entry>((v) => Entry.fromJson(v)).toList()
          as List<Entry>,
    );
  }

  Waitlist reOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    Entry newEntry = entries[oldIndex];
    newEntry.setIdx(newIndex);

    entries.removeAt(oldIndex);
    entries.insert(newIndex, newEntry);

    cleanIdx();

    return this;
  }

  void cleanIdx() {
    for (var i = 0; i < entries.length; i++) {
      entries[i].setIdx(i);
    }
  }
}

class WaitlistsDataModel {
  final List waitlists;

  WaitlistsDataModel({required this.waitlists});

  void updateWaitlist(Waitlist wl) {
    Waitlist waitlist = waitlists.firstWhere(
      (element) => element.date == wl.date,
      orElse: () => Waitlist(date: wl.date, entries: []),
    );
    if (waitlist.entries.isEmpty) {
      waitlists.add(Waitlist(date: wl.date, entries: []));
      waitlist = waitlists.firstWhere((element) => element.date == wl.date);
    }
    waitlists.removeWhere((w) => w.date == wl.date);
    waitlists.add(wl);
    waitlist.cleanIdx();
  }

  void remove(String date, Entry entry) {
    var waitlist = waitlists.firstWhere(
      (element) => element.date == date,
      orElse: () => Waitlist(date: date, entries: []),
    );
    waitlist.entries
        .removeWhere((item) => item.id == entry.id || item.idx == entry.idx);
    waitlist.cleanIdx();
  }

  int newIndex(String date) {
    var waitlist = waitlists.firstWhere(
      (element) => element.date == date,
      orElse: () => Waitlist(date: date, entries: []),
    );
    if (waitlist.entries.isEmpty) {
      return 0;
    }
    return waitlist.entries
            .map((entry) => entry.idx)
            .reduce((curr, next) => (curr > next) ? curr : next) +
        1;
  }

  Waitlist reorderWaitlist(String date, int oldIndex, int newIndex) {
    Waitlist waitlist = waitlists.firstWhere(
      (element) => element.date == date,
      orElse: () => Waitlist(date: date, entries: []),
    );

    if (waitlist.entries.isEmpty) {
      return Waitlist(date: date, entries: []);
    }

    return waitlist.reOrder(oldIndex, newIndex);
  }

  factory WaitlistsDataModel.fromJson(json) {
    return WaitlistsDataModel(
      waitlists: json.map((v) => Waitlist.fromJson(v)).toList(),
    );
  }
}
