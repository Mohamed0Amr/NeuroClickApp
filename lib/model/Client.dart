class Client{
  String? name;
  String? email;
  String? password;


  Client({this.name, this.email, this.password});
  Client.fromMap(Map<String, dynamic> map){
    name = map['name'];
    email = map['email'];

  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,

    };
  }
}