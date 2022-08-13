import 'package:flutter/material.dart';

class ServiceModel {
  static List<String> serviceNames = [
    'Spa Bath',
    'Brush Outs',
    'Ear Cleaning',
    'Teeth Brushing',
    'Nail Trims',
    'Self Wash Tubs',
    'Grooming'
  ];

  List<String> getServices() => serviceNames;

  Service getById(int id) =>
      Service(id, serviceNames[id % serviceNames.length]);

  Service getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Service {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Service(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Service && other.id == id;
}
