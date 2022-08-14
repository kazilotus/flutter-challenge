class Entry {
  final int idx;
  final String? id;
  final String name;
  final String? service;
  final bool completed;

  Entry(
      {this.id,
      required this.idx,
      required this.name,
      required this.service,
      required this.completed});

  Map toJson() => {
        'idx': idx,
        'name': name,
        'service': service,
        'completed': completed,
      };

  factory Entry.fromJson(Map<String, dynamic> json) {
    // print(json['_id']);
    return Entry(
      id: json['_id'],
      idx: json['idx'],
      name: json['name'],
      service: json['service'],
      completed: json['completed'],
    );
  }
}

class Waitlist {
  final String date;
  final List entries;

  Waitlist({
    required this.date,
    required this.entries,
  });

  factory Waitlist.fromJson(Map<String, dynamic> json) {
    return Waitlist(
      date: json['date'],
      entries: json['entries'].map((v) => Entry.fromJson(v)).toList(),
    );
  }
}

class WaitlistsDataModel {
  final List waitlists;

  WaitlistsDataModel({required this.waitlists});

  void updateWaitlist(Waitlist wl) {
    var waitlist = waitlists.firstWhere(
      (element) => element.date == wl.date,
      orElse: () => null,
    );
    if (waitlist == null) {
      waitlists.add(Waitlist(date: wl.date, entries: []));
      waitlist = waitlists.firstWhere((element) => element.date == wl.date);
    }
    waitlists.removeWhere((w) => w.date == wl.date);
    waitlists.add(wl);
  }

  // void insert(String date, Entry entry) {
  //   var waitlist = waitlists.firstWhere(
  //     (element) => element.date == date,
  //     orElse: () => null,
  //   );
  //   if (waitlist == null) {
  //     waitlists.add(Waitlist(date: date, entries: []));
  //     waitlist = waitlists.firstWhere((element) => element.date == date);
  //   }
  //   waitlist.entries.add(entry);
  // }

  // void remove(String date, Entry entry) {
  //   var waitlist = waitlists.firstWhere(
  //     (element) => element.date == date,
  //     orElse: () => null,
  //   );
  //   if (waitlist != null) {
  //     waitlist.entries.removeWhere((item) => item.id == entry.id);
  //   }
  // }

  int newIndex(String date) {
    var waitlist = waitlists.firstWhere(
      (element) => element.date == date,
      orElse: () => null,
    );
    if (waitlist == null || waitlist.entries.length == 0) {
      return 0;
    }
    return waitlist.entries
            .map((entry) => entry.idx)
            .reduce((curr, next) => (curr > next) ? curr : next) +
        1;
  }

  factory WaitlistsDataModel.fromJson(json) {
    return WaitlistsDataModel(
      waitlists: json.map((v) => Waitlist.fromJson(v)).toList(),
    );
  }
}
