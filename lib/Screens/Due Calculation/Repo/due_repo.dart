import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Const/api_config.dart';
import 'package:http/http.dart' as http;
import '../../../Provider/customer_provider.dart';
import '../../../Provider/profile_provider.dart';
import '../../../Provider/transactions_provider.dart';
import '../../../Repository/constant_functions.dart';
import '../Model/due_collection_invoice_model.dart';
import '../Model/due_collection_model.dart';
import '../Providers/due_provider.dart';

class DueRepo {
  Future<List<DueCollection>> fetchDueCollectionList() async {
    final uri = Uri.parse('${APIConfig.url}/dues');

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': await getAuthToken(),
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body) as Map<String, dynamic>;

      final dueList = parsedData['data'] as List<dynamic>;
      return dueList.map((due) => DueCollection.fromJson(due)).toList();
    } else {
      throw Exception('Failed to fetch Due List');
    }
  }

  Future<DueCollectionInvoice> fetchDueInvoiceList({required int id}) async {
    final uri = Uri.parse('${APIConfig.url}/invoices?party_id=$id');

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': await getAuthToken(),
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body);
      return DueCollectionInvoice.fromJson(parsedData['data']);
    } else {
      throw Exception('Failed to fetch Sales List');
    }
  }

  Future<DueCollection?> dueCollect({
    required WidgetRef ref,
    required BuildContext context,
    required num partyId,
    required String? invoiceNumber,
    required String paymentDate,
    required String paymentType,
    required num payDueAmount,
  }) async {
    final uri = Uri.parse('${APIConfig.url}/dues');
    final requestBody = jsonEncode({
      'party_id': partyId,
      'invoiceNumber': invoiceNumber,
      'paymentDate': paymentDate,
      'paymentType': paymentType,
      'payDueAmount': payDueAmount,
    });

    try {
      var responseData = await http.post(
        uri,
        headers: {"Accept": 'application/json', 'Authorization': await getAuthToken(), 'Content-Type': 'application/json'},
        body: requestBody,
      );

      final parsedData = jsonDecode(responseData.body);

      if (responseData.statusCode == 200) {
        EasyLoading.showSuccess('Collected successful!');

        ref.refresh(partiesProvider);
        ref.refresh(purchaseTransactionProvider);
        ref.refresh(salesTransactionProvider);
        ref.refresh(businessInfoProvider);
        ref.refresh(dueInvoiceListProvider(partyId.round()));
        ref.refresh(dueCollectionListProvider);

        return DueCollection.fromJson(parsedData['data']);
        // Navigator.pop(context);
        // return PurchaseTransaction.fromJson(parsedData);
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Purchase creation failed: ${parsedData['message']}')));
        return null;
      }
    } catch (error) {
      EasyLoading.dismiss();
      // Handle unexpected errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $error')));
      return null;
    }
  }
}
