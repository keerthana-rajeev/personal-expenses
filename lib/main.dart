// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './models/transactions.dart';

void main() => runApp(personal_expenses());

// ignore: camel_case_types, use_key_in_widget_constructors
class personal_expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      title: "Personal Expenses App",
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _userTransactions = [
    Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
    Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
    Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
    Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
    Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    // Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
    // Transactions(id: "t1", title: "Shoes", amount: 250, date: DateTime.now()),
    // Transactions(id: "t2", title: "Pants", amount: 450, date: DateTime.now()),
  ];
  List<Transactions> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTx(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTx);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Personal Expenses'),
      backgroundColor: Colors.brown.shade700,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.25,
              child: Chart(_recentTransaction),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.75,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.indigo[900],
        onPressed: () => _startAddNewTransaction(context),
      ),
      backgroundColor: Colors.brown.shade50,
    );
  }
}
