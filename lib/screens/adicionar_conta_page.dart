import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/conta_service.dart';

class AdicionarConta extends StatelessWidget {
  ContaService contaService = ContaService("contas");

  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();

  AdicionarConta({super.key});

  void add() async {
    String desc = descricao.text;
    String val = valor.text;

    if (desc.isNotEmpty) {
      var conta = {'descricao': desc, 'val': val};

      await contaService.create(conta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00cc73),
        title: const Text(
          "Adicionar conta",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da conta',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
              controller: descricao,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valor da conta (R\$)',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
              inputFormatters: [
                CurrencyTextInputFormatter.currency(
                  locale: 'pt-br',
                  decimalDigits: 2,
                  symbol: '',
                ),
              ],
              controller: valor,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                    child: Material(
                  color: Color(0xFF00cc73),
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    onTap: () async {
                      add();
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15.0),
                    child: GestureDetector(
                      onLongPress: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Tap'),
                        ));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cadastrar",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
