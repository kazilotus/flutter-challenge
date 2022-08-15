import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app/models/data/waitlists.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Get all waiting lists for all dates
Future<WaitlistsDataModel?> getWaitlists() async {
  WaitlistsDataModel? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/waitlists";
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

// Update a complete waiting list for a particular day
Future<WaitlistsDataModel?> patchWaitlist(
    String date, Waitlist waitlist) async {
  WaitlistsDataModel? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/waitlist/$date";
    String data = jsonEncode(waitlist.toJson());
    final response = await http.patch(
      Uri.parse(endpoint),
      body: data,
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

// Create an entry for a waitlist in a particular day
Future<Waitlist?> postWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date";
    String data = jsonEncode(entry.toJson());
    final response = await http.post(
      Uri.parse(endpoint),
      body: data,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
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

// Delete an entry from a waitlist in a particular day
Future<Waitlist?> deleteWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date/${entry.id}";
    final response = await http.delete(
      Uri.parse(endpoint),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
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

// Update an entry for a waitlist in a particular day
Future<Waitlist?> patchWaitlistEntry(String date, Entry entry) async {
  Waitlist? result;
  try {
    String? endpoint = "${dotenv.env['API_ENDPOINT']}/entry/$date/${entry.id}";
    String data = jsonEncode(entry.toJson());
    final response = await http.patch(
      Uri.parse(endpoint),
      body: data,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    if (response.statusCode == 200) {
      final jason = json.decode(response.body);
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
