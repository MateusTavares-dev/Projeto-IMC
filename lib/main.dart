import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false, // Opcional: tira a faixa de debug
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controladores para pegar o texto digitado nos campos
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // Texto que exibe o resultado
  String _infoText = "Informe seus dados!";

  // Função para limpar os campos (Botão de refresh na AppBar)
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  // Função para calcular o IMC (Botão Calcular)
  void _calculate() {
    setState(() {
      // Verificação simples se os campos não estão vazios
      if (weightController.text.isEmpty || heightController.text.isEmpty) {
        _infoText = "Preencha peso e altura!";
        return;
      }

      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) /
          100; // Convertendo cm para metros
      double imc = weight / (height * height);

      print(imc); // Só para debug no console

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'), // Conforme Print 1
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(255, 5, 136, 243), // Cor aproximada do Print 1
        actions: <Widget>[
          IconButton(
            onPressed: _resetFields, // Chama a função de limpar
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor:
          const Color.fromARGB(255, 175, 209, 236), // Cor de fundo do Print 4
      body: SingleChildScrollView(
        // Adicionado para permitir rolagem (Print 4 e 5)
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline_sharp,
                size: 140.0, color: Colors.blue // Conforme Print 2
                ),

            // Campo de Peso
            TextField(
              controller: weightController, // Controlador adicionado
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25.0),
            ),

            // Campo de Altura
            TextField(
              controller: heightController, // Controlador adicionado
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue, fontSize: 25.0), // Conforme Print 3
            ),

            // Botão Calcular
            Padding(
              // Padding adicionado conforme Print 6
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 40.0, // Altura conforme Print 3
                child: ElevatedButton(
                  onPressed: _calculate, // Chama a função de calcular
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),

            // Texto de Resultado (Info)
            Text(
              _infoText, // Variável que muda o texto
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          ],
        ),
      ),
    );
  }
}
