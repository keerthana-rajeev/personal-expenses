import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

//This is a widget so place in widget folder
class TransactionList extends StatelessWidget {
  final List<Transactions> transaction;
  final Function deleteTrans;
  TransactionList(this.transaction, this.deleteTrans);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transaction.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "No transaction added yet!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  child: Image.asset(
                    'lib/assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange.shade900,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$' +
                              transaction[index].amount.toStringAsFixed(2)),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteTrans(transaction[index].id),
                      icon: Icon(Icons.delete),
                      color: Colors.red[900],
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: [
                //       // ignore: avoid_unnecessary_containers
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.brown.shade700,
                //             width: 2,
                //           ),
                //         ),
                //         padding: EdgeInsets.all(5),
                //         child: Text(
                //           '\$' + transaction[index].amount.toStringAsFixed(2),
                //           style: TextStyle(
                //             fontSize: 20,
                //             color: Colors.deepOrangeAccent.shade700,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transaction[index].title,
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 18,
                //             ),
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(transaction[index].date),
                //             style: TextStyle(
                //               color: Colors.grey[600],
                //               fontSize: 15,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
