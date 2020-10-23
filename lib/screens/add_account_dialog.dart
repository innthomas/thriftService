import 'package:flutter/material.dart';
import 'package:thriftService/model/account_model.dart';

class AddUserDialog {
  final acctNameController = TextEditingController();
  final acctNumberController = TextEditingController();
  final acctBalanceController = TextEditingController();
  final acctMobileController = TextEditingController();
  final acctDepositController = TextEditingController();
  final acctWithrawalController = TextEditingController();
  Account account;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddAccountCallback _myHomePageState, bool isEdit, Account account) {
    if (account != null) {
      this.account = account;
      acctNameController.text = account.acctName;
      acctNumberController.text = account.acctNumber;
      acctDepositController.text = account.acctDeposit;
      acctMobileController.text = account.mobile;
      acctBalanceController.text = account.acctBalance;
      acctWithrawalController.text = account.acctWithrawal;
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Edit detail!' : 'Add new Account!'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("acctName", acctNameController),
            getTextField("acctNumber", acctNumberController),
            getTextField("acctBalance", acctBalanceController),
            getTextField("acctDeposit", acctDepositController),
            getTextField("acctWithrawal", acctWithrawalController),
            getTextField("Mobile", acctMobileController),
            new GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Account getData(bool isEdit) {
    return new Account(
      isEdit ? account.id : "",
      acctNameController.text,
      acctBalanceController.text,
      acctNumberController.text,
      acctDepositController.text,
      acctWithrawalController.text,
      acctMobileController.text,
    );
  }

  onTap(
      bool isEdit, AddAccountCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
    } else {
      _myHomePageState.addAccount(getData(isEdit));
    }

    Navigator.of(context).pop();
  }
}

//Call back of user dashboad
abstract class AddAccountCallback {
  void addAccount(Account account);

  void update(Account account);
}
