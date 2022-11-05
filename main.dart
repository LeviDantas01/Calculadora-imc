import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';


void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoCon = TextEditingController();
  TextEditingController alturaCon = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _limpar() {
    pesoCon.text = "";
    alturaCon.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoCon.text);
      double altura = double.parse(alturaCon.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemnte acima do peso (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 40) {
        _infoText = "Você vai morrer. seu gordo (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _limpar(),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.greenAccent,
              ),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu peso!";
                  }
                },
                controller: pesoCon,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso em kg",
                  labelStyle: TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 25,
                ),
                // inputFormatters: [
                //   PesoInputFormatter(),
                // ],
              ),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira sea altura!";
                  }
                },
                controller: alturaCon,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura",
                  labelStyle: TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 25,
                ),
                // inputFormatters: [
                //   AlturaInputFormatter(),
                // ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _calcular();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.greenAccent),
                    ),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
