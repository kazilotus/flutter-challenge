import 'package:app/models/data/waitlists.dart';
import 'package:app/service/waitlist.dart';
import 'package:flutter/material.dart';

class WaitlistsData extends ChangeNotifier {
  WaitlistsDataModel? waitlistsModel;
  bool initialized = false;
  bool loading = false;

  getWaitlistsData() async {
    loading = true;
    waitlistsModel = (await getWaitlists());
    initialized = true;
    loading = false;
    notifyListeners();
  }

  insertWaitlistEntry(String date, Entry entry) async {
    Waitlist wl = (await postWaitlistEntry(date, entry))!;
    waitlistsModel!.updateWaitlist(wl);
    notifyListeners();
  }

  removeWaitlistEntry(String date, Entry entry) async {
    Waitlist wl = (await deleteWaitlistEntry(date, entry))!;
    waitlistsModel!.updateWaitlist(wl);
    notifyListeners();
  }

  updateWaitlistEntry(String date, Entry entry) async {
    Waitlist wl = (await patchWaitlistEntry(date, entry))!;
    waitlistsModel!.updateWaitlist(wl);
    notifyListeners();
  }

  reorderWaitlistEntry(String date, Waitlist waitlist) async {
    waitlistsModel = (await patchWaitlist(date, waitlist));
    waitlistsModel?.updateWaitlist(waitlist);
    notifyListeners();
  }
}
