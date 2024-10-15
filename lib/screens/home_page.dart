import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/conta.dart';
import 'package:mobile/screens/adicionar_conta_page.dart';
import 'package:mobile/services/conta_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContaService contaService = ContaService("contas");

  List<Conta> contasArray = [];

  void getContas() async {
    var todasContas = await contaService.getAll();
    List<dynamic> contas = [];
    List<Conta> contasObj = [];
    contas = jsonDecode(todasContas);

    for (int i = 0; i < contas.length; i++) {
      contasObj.add(Conta.fromDynamic(contas[i]));
    }

    setState(() {
      contasArray = contasObj;
    });
  }

  @override
  void initState() {
    getContas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008c4f),
        title: const Text(
          "Registro de contas",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: contasArray.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Text("Nome da conta: "),
                  ],
                ),
                Row(
                  children: [
                    Text(contasArray[index].descricao),
                  ],
                ),
                Row(
                  children: [
                    Text("Valor: "),
                  ],
                ),
                Row(
                  children: [
                    Text(contasArray[index].valor),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00cc73),
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarConta()),
          );
        },
      ),
    );
  }
}
