import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cep_model.dart';

class CepService {
  Future<CepModel?> fetchCep(String cep) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CepModel.fromJson(data);
    } else {
      throw Exception('Falha ao carregar CEP');
    }
  }
}