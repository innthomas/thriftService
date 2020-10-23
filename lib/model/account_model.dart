import 'package:firebase_database/firebase_database.dart';

class Account {
  String _id;
  String _acctName;
  String _acctNumber;
  String _acctDeposit;
  String _acctWithrawal;
  String _acctBalance;
  String _mobile;
  Account(
    this._acctName,
    this._acctNumber,
    this._acctDeposit,
    this._id,
    this._acctWithrawal,
    this._acctBalance,
    this._mobile,
  );
  String get acctBalance => _acctBalance;
  String get id => _id;
  String get acctName => _acctName;
  String get acctNumber => _acctNumber;
  String get mobile => _mobile;
  String get acctDeposit => _acctDeposit;
  String get acctWithrawal => _acctWithrawal;

  Account.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _acctName = snapshot.value['acctName'];
    _mobile = snapshot.value['mobile'];
    _acctBalance = snapshot.value['acctBalance'];
    _acctDeposit = snapshot.value['acctDeposit'];
    _acctWithrawal = snapshot.value['acctWithrawal'];
    _acctNumber = snapshot.value['acctNumber'];
  }
}
