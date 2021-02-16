import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  // criar Stateful pois a tela sofrerá alterações
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController entradaPeso = TextEditingController();
  TextEditingController entradaAltura = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _msgIMC = "Informe seus dados!";

  void _resetFields() {
    entradaPeso.text = "";
    entradaAltura.text = "";
    setState(() {
      _msgIMC = "Informe seus dados!";
    });
  }

  void calculaIMC() {
    double _peso = double.parse(entradaPeso.text);
    double _altura = double.parse(entradaAltura.text);

    setState(() {
      double imc = _peso / ((_altura / 100) * (_altura / 100));

      if (imc < 18.5) {
        _msgIMC = "Abaixo do Peso";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _msgIMC = "Peso Normal";
      } else if (imc >= 25 && imc <= 29.9) {
        _msgIMC = "Sobrepeso";
      } else if (imc >= 30 && imc <= 34.9) {
        _msgIMC = "Obesidade grau I";
      } else if (imc >= 35 && imc <= 39.5) {
        _msgIMC = "Obesidade grau II";
      } else {
        _msgIMC = "Obesidade Grau III ou Mórbida";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.black12,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_add_outlined,
                    size: 120.0, color: Colors.black54),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 22.0),
                  controller: entradaPeso,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.black54),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 22.0),
                  controller: entradaAltura,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          calculaIMC();
                        }
                      },
                      child: Text("Calcular",
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.0)),
                      color: Colors.black54,
                    ),
                  ),
                ),
                Text(
                  _msgIMC,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 22.0),
                )
              ],
            ),
          ),
        ));
  }
}
