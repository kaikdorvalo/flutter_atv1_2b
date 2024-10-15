import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AbstractApi {
  final String urlLocalHost = "http://localhost:3000";

  String _recurso;

  AbstractApi(this._recurso);

  Future<String> getAll() async {
    var response = await http.get(Uri.parse("$urlLocalHost/$_recurso"));
    return response.body;
  }

  Future<String> create(dynamic data) async {
    var response = await http.post(Uri.parse("$urlLocalHost/$_recurso"),
        body: jsonEncode(data));
    return response.body;
  }
}
