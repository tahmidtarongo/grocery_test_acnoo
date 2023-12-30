import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_pos/Const/api_config.dart';

import '../../Screens/Customers/Model/parties_model.dart';
import '../constant_functions.dart';

class PartyRepository {
  Future<List<Party>> fetchAllParties() async {
    final uri = Uri.parse('${APIConfig.url}/parties');

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': await getAuthToken(),
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body) as Map<String, dynamic>;

      final partyList = parsedData['data'] as List<dynamic>;
      return partyList.map((category) => Party.fromJson(category)).toList();
      // Parse into Party objects
    } else {
      throw Exception('Failed to fetch parties');
    }
  }
}
