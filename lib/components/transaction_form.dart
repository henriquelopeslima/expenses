import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _seletedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _seletedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _seletedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return null;
      setState(() {
        _seletedDate = pickedDate;
      });
    });
  }

  _showModalBottomSheet() {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _seletedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selecionada: ' +
                                DateFormat('dd/MM/y').format(_seletedDate),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Nova Transação'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
