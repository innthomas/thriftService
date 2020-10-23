import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:thriftService/model/account_model.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _accountRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    //TODO changed from 'user' to "Account"
    _accountRef = database.reference().child('account');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getAccount() {
    return _accountRef;
  }

  addAccount(Account account) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _accountRef.push().set(<String, String>{
        "acctName": "" + account.acctName,
        "acctNumber": "" + account.acctNumber,
        "acctDeposit": "" + account.acctDeposit,
        "acctWithrawal": "" + account.acctWithrawal,
        "acctBalance": "" + account.acctBalance,
        "mobile": "" + account.mobile,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteAccount(Account account) async {
    await _accountRef.child(account.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateAccount(Account account) async {
    await _accountRef.child(account.id).update({
      "acctName": "" + account.acctName,
      "acctNumber": "" + account.acctNumber,
      "acctDeposit": "" + account.acctDeposit,
      "acctWithrawal": "" + account.acctWithrawal,
      "acctBalance": "" + account.acctBalance,
      "mobile": "" + account.mobile,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
