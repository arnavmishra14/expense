import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller=TextEditingController();

  final amountcontroller=TextEditingController();
  DateTime selectdate;

  void submitdata(){
    final String ftc=titlecontroller.text;
    final double atc=double.parse(amountcontroller.text);
    if(ftc.isEmpty || atc<=0 || selectdate==null){
      return;
    }
    widget.addtx(ftc,atc,selectdate);
    Navigator.of(context).pop(); 

  }
  void adate(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now(),).then((datepi) {
      if(datepi==null){
        return;
      }
      setState(() {
        selectdate=datepi;
      });
      

    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,

        child: Container(
          padding: EdgeInsets.only(top:10,right: 10,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titlecontroller,
                onSubmitted: (_){
                  submitdata();

                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted:(_){
                  submitdata();
                }
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(selectdate==null?'No Date chosen':DateFormat.yMd().format(selectdate))),

                    FlatButton(onPressed: adate, textColor: Theme.of(context).primaryColor,child: Text('Pick a date',style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
              RaisedButton(
                child: Text('add transaction'),
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: (){
                  widget.addtx(titlecontroller.text,double.parse(amountcontroller.text));

      },

              ),
            ],
          ),

        ),


      ),
    );
  }
}
