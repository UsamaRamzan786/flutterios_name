import 'dart:convert';

import 'package:http/http.dart' as http;

class GetAPI {
  Future apiData() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    //"https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=23D9641E-803E-4878-B7E5-13DC9F9DC1EE"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('Error: Feaching APi');
    }
  }
}
