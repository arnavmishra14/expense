import 'package:flutter/material.dart';
import 'package:flutter_app_personalexpense/chartbar.dart';
import './transcition.dart';
import 'package:intl/intl.dart';


class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;
  Chart(this.recenttransaction);
  List<Map<String, Object>> get gt{
    return List.generate(7,(index){
      final weekday=DateTime.now().subtract(Duration(days:index),);
      double totalsum=0;
      for(var i=0;i<recenttransaction.length;i++){
        if(recenttransaction[i].date.day==weekday.day && recenttransaction[i].date.month==weekday.month && recenttransaction[i].date.year==weekday.year){
          totalsum+=recenttransaction[i].amount;
        }
      }

      return {
        'day':DateFormat.E().format(weekday).substring(0,1),'amount':totalsum};



    }).reversed.toList();

  }
  double get ts{
    return gt.fold(0.0, (sum, item) {
      return sum+item['amount'];


    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:5,
      margin: EdgeInsets.all(20),
      child:Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: gt.map((data) {
            return Flexible(
              fit:FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                  ts==0?0.0:(data['amount'] as double) / ts
              ),
            ) ;


          }).toList()



    ),
      ),

    );
  }
}

