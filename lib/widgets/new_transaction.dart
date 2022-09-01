import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//This is for the textfields
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late final _titleController = TextEditingController();
  late final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null)
      return;
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void Datepicking() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
      print(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lastDate;
    var initialDate;
    return Container(
      child: Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.brown.shade900,
                    ),
                  ),
                ),
                cursorColor: Colors.black54,
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.brown.shade900,
                    ),
                  ),
                ),
                cursorColor: Colors.black54,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen!"
                          : "Picked date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}",
                    ),
                  ),
                  FlatButton(
                    onPressed: Datepicking,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.blue.shade800,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange[900],
                    onPrimary: Colors.white,
                    elevation: 0),
                child: Text(
                  "Add Transaction",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
