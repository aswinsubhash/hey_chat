import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  //getting access to contacts in phone
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      //permission request to the contacts
      if (await FlutterContacts.requestPermission()) {
        //getting contacts
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }
}

//3.00.0 search in fire base 
//to identify the contact available or not 