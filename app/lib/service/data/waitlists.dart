import 'package:app/models/data/waitlists.dart';
import 'package:app/service/waitlist.dart';
import 'package:flutter/material.dart';

class WaitlistsData extends ChangeNotifier {
  WaitlistsDataModel? waitlistsModel;
  bool initialized = false;
  bool loading = false;

  getWaitlistsData() async {
    loading = true;
    waitlistsModel = (await getWaitlists())!;
    initialized = true;
    loading = false;
    notifyListeners();
  }

  insertWaitlistEntry(String date, Entry entry) async {
    Waitlist wl = (await createWaitlistEntry(date, entry))!;
    waitlistsModel!.updateWaitlist(wl);
    // waitlistsModel?.insert(date, entry);
    notifyListeners();
  }

  removeWaitlistEntry(String date, Entry entry) async {
    Waitlist wl = (await deleteWaitlistEntry(date, entry))!;
    waitlistsModel!.updateWaitlist(wl);
    // waitlistsModel?.remove(date, entry);
    notifyListeners();
  }
}
