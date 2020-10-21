import 'package:flutter/material.dart';
import 'package:myDataTable_app/model/account_model.dart';

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<Account> accounts;

  TextEditingController amtController = TextEditingController();
  @override
  void initState() {
    // accounts = Account.getAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("AcctNumber")),
        DataColumn(label: Text("AcctName")),
        DataColumn(label: Text("AcctBalance")),
        DataColumn(label: Text("action"))
      ],
      rows: accounts
          .map(
            (account) => DataRow(cells: [
              DataCell(
                Text(account.acctNumber.toString()),
                onTap: () {
                  print('Selected ${account.acctNumber}');
                },
              ),
              DataCell(
                Text(account.acctName),
                onTap: () {
                  print('Selected ${account.acctName}');
                },
              ),
              DataCell(
                Text(account.getAcctBalance.toString()),
                onTap: () {
                  buildShowDialog(context, account);
                  print('Selected ${account.getAcctBalance}');
                },
              ),
              DataCell(
                IconButton(icon: Icon(Icons.description), onPressed: null),
                onTap: () {},
              ),
            ]),
          )
          .toList(),
    );
  }

  Future buildShowDialog(BuildContext context, Account account) {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Column(
                children: [
                  new Text(account.acctName),
                  new Text(account.acctNumber.toString()),
                ],
              ),
              content: new TextFormField(
                decoration: InputDecoration(labelText: "amount"),
                keyboardType: TextInputType.number,
                controller: amtController,
                onSaved: (newValue) {
                  // double balance = double.parse(newValue);
                },
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Deposit!'),
                  onPressed: () {
                    setState(() {
                      // account.acctBalance;
                    });
                    print(account.getAcctBalance);
                    print(amtController.text);
                    //account.setDeposit = double.parse(amtController.text);
                    setState(() {
                      // = double.parse(amtController.text);
                      amtController.clear();
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
