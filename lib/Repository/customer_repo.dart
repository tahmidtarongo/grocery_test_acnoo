import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_pos/Screens/Customers/Model/parties_model.dart';

import '../constant.dart';

class CustomerRepo {
  Future<List<Party>> getAllCustomers() async {
    List<Party> customerList = [];
    final ref = FirebaseDatabase.instance.ref(constUserId).child('Customers');

    await ref.orderByKey().get().then((value) {
      for (var element in value.children) {
        customerList.add(Party.fromJson(jsonDecode(jsonEncode(element.value))));
      }
    });
    ref.keepSynced(true);
    return customerList;
  }
}
