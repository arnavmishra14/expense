import 'package:flutter/material.dart';
import 'package:flutter_app_personalexpense/Chart.dart';
import 'package:flutter_app_personalexpense/new_transaction.dart';
import './transcition.dart';
import './transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:MyHomePage(),
      theme: ThemeData(

        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(subtitle1: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold),
        button: TextStyle(color: Colors.white)),


        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(subtitle1: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold)),)
      ),


    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> userTransaction=[
    /*Transaction(
      id:'t1',
      amount:20,
      title: 'Shoes',
      date: DateTime.now(),
    ),
    Transaction(
      id:'t2',
      amount:40,
      title: 'Laptop',
      date: DateTime.now(),
    )*/

  ];
  List<Transaction> get rt{
  return userTransaction.where(
    (tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
  }
    ).toList();
  }

  void addtransaction(String txtitle,double txamount,DateTime cdt){
    final tx=Transaction(
      title: txtitle,
      amount: txamount,
      date: cdt,
      id:DateTime.now().toString(),
    );
    setState(() {
      userTransaction.add(tx);
    });
  }
  void deltra(String id){
    setState(() {
      userTransaction.removeWhere((element) {
        return element.id==id;

    });
    
    });
  }
  void addNewtransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){

        },
          child:NewTransaction(addtransaction),
      behavior: HitTestBehavior.opaque,);

    });
  }
   bool showchart=false;
  @override
  Widget build(BuildContext context) {
    final islandscape=MediaQuery.of(context).orientation==Orientation.landscape;

    final appBar=AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed:(){
          addNewtransaction(context);

        }),
      ],
    );
    final txwidget=Container
      (
        height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
        child: TransactionList(userTransaction,deltra));
    return Scaffold(
      appBar: appBar,
      body:
         SingleChildScrollView(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(islandscape)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch(value:showchart , onChanged: (val){
                    setState(() {
                      showchart=val;
                    });
                  })

                ],
              ),
            if(!islandscape) Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,

                child: Chart(rt)),
            if(!islandscape) txwidget,

            if(islandscape)showchart?Container(
              height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6,

                child: Chart(rt)):
              txwidget,




        ],),
         ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:FloatingActionButton(
          child: Icon(Icons.add),
            onPressed:(){
            addNewtransaction(context);
            }
        )
      );

  }
}





 