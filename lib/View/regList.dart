import 'package:flutter/material.dart';
import 'package:registration/Model/db_helper.dart';
import 'package:registration/Model/reg_model.dart';

class RegList extends StatefulWidget {
  @override
  _RegListState createState() => _RegListState();
}

class _RegListState extends State<RegList> {
  List<Registration> list = new List();
  dbhelper db = dbhelper();

  @override
  void initState() {
    super.initState();
    db.getAllNotes().then((reg) {
      setState(() {
        reg.forEach((re) {
          list.add( Registration.frommap(re));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Of Registration"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: <Widget>[Text('${list[index].name}'),Text(list[index].lastname),Text(list[index].dob)],
              ),
            );
          }),
    );
  }
}
