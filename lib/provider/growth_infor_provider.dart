import 'package:baby/models/growth/growth_info.dart';
import 'package:flutter/material.dart';

class GrowthInforProvider extends ChangeNotifier {
  List<GrowthInforRecord> records = [
    GrowthInforRecord(time: DateTime(2022, 01, 01), weight: 4.5, height: 40),
    GrowthInforRecord(time: DateTime(2022, 01, 01), weight: 4.5, height: 40),
    GrowthInforRecord(time: DateTime(2022, 01, 01), weight: 4.5, height: 40),
    GrowthInforRecord(time: DateTime(2022, 01, 01), weight: 4.5, height: 40),
    GrowthInforRecord(time: DateTime(2022, 01, 01), weight: 4.5, height: 40)
  ];
  void sortRecords() {
    records.sort((a, b) => b.compareTo(a));
  }

  void addRecord(GrowthInforRecord record) {
    records.add(record);
    sortRecords();
    notifyListeners();
  }

  void editRecord(int index, GrowthInforRecord record) {
    records[index] = record;
    sortRecords();
    notifyListeners();
  }

  void deleteRecord(int index) {
    records.removeAt(index);
    notifyListeners();
  }
}
