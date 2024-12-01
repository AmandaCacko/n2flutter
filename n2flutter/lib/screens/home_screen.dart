import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../services/cep_service.dart';
import '../models/cep_model.dart';
import '../widgets/cep_input_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MaskedTextController _cepController = MaskedTextController(mask: '00000-000');
  String _errorMessage = '';
  CepModel? _cepResult;

  Future<void> _consultCep() async {
    setState(() {
      _errorMessage = '';
      _cepResult = null;
    });

    try {
      final cep = _cepController.text.replaceAll('-', ''); 
      final result = await CepService().fetchCep(cep);

      setState(() {
        _cepResult = result;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao consultar CEP. Tente novamente!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP - Amanda Almeida Cacko - 30/11/2024'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CepInputWidget(controller: _cepController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _consultCep,
              child: const Text('Consultar CEP'),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            if (_cepResult != null) ...[
              Text('CEP: ${_cepResult!.cep}'),
              Text('Logradouro: ${_cepResult!.logradouro}'),
              Text('Complemento: ${_cepResult!.complemento}'),
              Text('Bairro: ${_cepResult!.bairro}'),
              Text('Localidade: ${_cepResult!.localidade}'),
              Text('UF: ${_cepResult!.uf}'),
            ],
          ],
        ),
      ),
    );
  }
}
