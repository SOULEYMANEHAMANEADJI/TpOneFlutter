// api_service.dart
import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchNotesFromServer() async {
  final response = await http.get(Uri.parse(
      'https://console.firebase.google.com/u/0/project/endtpone/firestore/data/notes'));
  if (response.statusCode == 200) {
    List<dynamic> notesJson = json.decode(response.body);
    return notesJson.map((note) => Map<String, dynamic>.from(note)).toList();
  } else {
    throw Exception('Failed to load notes from server');
  }
}

Future<List<Map<String, dynamic>>> fetchNotesFromFirebase() async {
  final response = await http.get(Uri.parse(
      'https://console.firebase.google.com/u/0/project/endtpone/firestore/data/notes'));
  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load notes from server');
  }
}

Future<void> addNoteToFirestore(String title, String content) async {
  await FirebaseFirestore.instance.collection('notes').add({
    'title': title,
    'content': content,
  });
}
