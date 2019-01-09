
class Registration{
  String name;
  String lastname;
  String dob;

  Registration(this.name,this.lastname,this.dob);

  Registration.frommap(Map<String,dynamic> data){
    this.name=data['Name'];
    this.lastname=data['LastName'];
    this.dob=data['DOB'];
  }

  Map<String,dynamic> Tomap(){
    var map = Map<String,dynamic>();
    map['Name'] = name;
    map['LastName'] = lastname;
    map['DOB'] = dob;
    return map;
  }

}

