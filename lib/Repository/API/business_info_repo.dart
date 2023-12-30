import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_pos/Const/api_config.dart';

import '../../model/business_info_model.dart';
import '../constant_functions.dart';

class BusinessRepository {
  Future<BusinessInformationModel> fetchBusinessData() async {
    final uri = Uri.parse('${APIConfig.url}/business');
    final token = await getAuthToken(); // Replace with your token retrieval logic

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // Assuming Bearer token format
    });

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body);
      print(parsedData['data']);
      return BusinessInformationModel.fromJson(parsedData['data']); // Extract the "data" object from the response
    } else {
      throw Exception('Failed to fetch business data');
    }
  }
}
