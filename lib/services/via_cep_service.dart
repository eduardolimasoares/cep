import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cep/models/cep.dart';

class ViaCepService {
  final String _baseUrl = 'https://viacep.com.br/ws/';

  Future<Cep> fetchCep(String cep) async {
    final response = await http.get(Uri.parse('$_baseUrl$cep/json/'));

    if (response.statusCode == 200) {
      return Cep.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load CEP');
    }
  }
}
