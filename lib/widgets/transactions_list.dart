import 'package:flutter/material.dart';
import 'package:flutter_application_personalexpences/modules/transactions.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactions;
  final deleteTx;

  TransactionsList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "No transactions!",
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          "\$${transactions[index].price}",
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
              //   return Card(
              //     child: Row(
              //       children: <Widget>[
              //         Container(
              //           margin: EdgeInsets.symmetric(
              //             vertical: 10,
              //             horizontal: 15,
              //           ),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: Theme.of(context).primaryColor,
              //               width: 2,
              //             ),
              //           ),
              //           padding: EdgeInsets.all(10),
              //           child: Text(
              //             "\$${transactions[index].price.toStringAsFixed(2)}",
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Theme.of(context).primaryColor,
              //             ),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(
              //               transactions[index].title,
              //               // ignore: deprecated_member_use
              //               style: Theme.of(context).textTheme.title,
              //             ),
              //             Text(
              //               DateFormat.yMMMd().format(transactions[index].date),
              //               style: TextStyle(
              //                 color: Colors.grey, /*fontSize: 10*/
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   );
            },
            itemCount: transactions.length,
          );
  }
}
