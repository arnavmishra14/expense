import 'package:flutter/material.dart';
import './transcition.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function del;
  TransactionList(this.transactions,this.del);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty? LayoutBuilder(
        builder: (ctx,constraints){
          return Column(
            children: [
              Text('No Transaction',
                style: Theme.of(context).textTheme.headline6,),
              SizedBox(height: 10),
              Container(
                  height: (constraints.maxHeight)*0.6,
                  child: Image.asset('assest/images/waiting.png',fit: BoxFit.cover)),

            ],
          );
        }

      )



          :ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 1,
                      )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                          color:Colors.grey,
                        ),


                      ),
                    ],

                  ),
                ),
                IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor, onPressed: (){del(transactions[index].id);})
              ],

            ),
          );
        },
        itemCount: transactions.length,

      ),
    );
  }
}
