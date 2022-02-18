import 'dart:convert';
import '_key.dart';
import 'package:http/http.dart' as http;

class APIConnect {
  String baseURL = 'https://rest.coinapi.io/v1/exchangerate/';

  Future<dynamic> getAPIResults(
      {required String baseCurrency, required String targetCurrency}) async {
    try {
      String url = "$baseURL$targetCurrency/$baseCurrency?apikey=$APIKEY";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
