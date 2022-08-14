import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/models/data/waitlists.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<WaitlistsDataModel?> getWaitlists() async {
  WaitlistsDataModel? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/waitlists";
    if (kDebugMode) {
      print(endpoint);
    }
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
      result = WaitlistsDataModel.fromJson(jason);
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}

Future<Waitlist?> postWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date";
    String data = json.encode(entry);
    if (kDebugMode) {
      print(endpoint);
      print(data);
    }
    final response = await http.post(
      Uri.parse(endpoint),
      body: data,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
      if (kDebugMode) {
        print(jason);
      }
      result = Waitlist.fromJson(jason);
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}

Future<Waitlist?> deleteWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date/${entry.id}";
    if (kDebugMode) {
      print(endpoint);
    }
    final response = await http.delete(
      Uri.parse(endpoint),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
      if (kDebugMode) {
        print(jason);
      }
      result = Waitlist.fromJson(jason);
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}

Future<Waitlist?> patchWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date/${entry.id}";
    String data = json.encode(entry);
    if (kDebugMode) {
      print(endpoint);
      print(data);
    }
    final response = await http.patch(
      Uri.parse(endpoint),
      body: data,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
      if (kDebugMode) {
        print(jason);
      }
      result = Waitlist.fromJson(jason);
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}
