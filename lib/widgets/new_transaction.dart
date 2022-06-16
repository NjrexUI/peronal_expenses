import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTxAdds;

  NewTransaction(this.newTxAdds);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextController = TextEditingController();
  final priceTextController = TextEditingController();
  DateTime selectedDate;

  void submit() {
    if (priceTextController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleTextController.text;
    final enteredPrice = double.parse(priceTextController.text);

    if (enteredPrice <= 0 || enteredTitle.isEmpty || selectedDate == null) {
      return;
    }

    widget.newTxAdds(
      enteredTitle,
      enteredPrice,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // ignore: unnecessary_statements
        selectedDate = pickedDate;
      });
      print(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleTextController,
                onSubmitted: (_) => submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Price"),
                controller: priceTextController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "No date chosen!"
                            : "Picked date: ${DateFormat.yMd().format(selectedDate)}",
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Choose date...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add transaction..."),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
