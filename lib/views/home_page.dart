import 'package:flutter/material.dart';
import 'package:cep/models/cep.dart';
import 'package:cep/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ViaCepService _viaCepService;
  Cep? _currentCep;
  final _cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viaCepService = ViaCepService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                final cep = _cepController.text;
                try {
                  final result = await _viaCepService.fetchCep(cep);
                  setState(() {
                    _currentCep = result;
                  });
                } catch (e) {
                  // Handle the exception
                }
              },
              child: Text('Consultar'),
            ),
            if (_currentCep != null)
              Text('Endereço: ${_currentCep!.logradouro}, ${_currentCep!.bairro}, ${_currentCep!.localidade} - ${_currentCep!.uf}')
          ],
        ),
      ),
    );
  }
}
