import 'package:flutter/material.dart';
import 'package:registration/Model/db_helper.dart';
import 'package:registration/Model/reg_model.dart';
import 'package:registration/View/regList.dart';

class Reg extends StatefulWidget {
  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {
  dbhelper db = dbhelper();
  TextEditingController r1, r2, r3;

  @override
  void initState() {
    r1 = TextEditingController();
    r2 = TextEditingController();
    r3 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    r1.dispose();
    r2.dispose();
    r3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {


              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [Column(
            children: <Widget>[
              buildTextFormField(
                  r1, 'Name As In Adhar', 'Name', Icon(Icons.person)),
              buildTextFormField(r2, 'Last Name as eg. Rathod', 'LastName',
                  Icon(Icons.perm_identity)),
              buildTextFormField(
                  r3, 'Birthday Date', 'DOB', Icon(Icons.calendar_today)),
              FlatButton(
                  onPressed: () {
                    db.saveNote(Registration(r1.text, r2.text, r3.text));
                  },
                  child: Text("Save")),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => RegList()));
                  },
                  child: Text("List"))
            ],
          )],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(controller, hint, label, icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, labelText: label, icon: icon),
    );
  }
}
