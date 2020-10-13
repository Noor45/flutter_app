import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  var data;
  Networking(this.url);
  final String url;

  Future getData() async{
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
       data = response.body;
       var jsonData = jsonDecode(data);
       return jsonData;
    }
    else {
      print(response.statusCode);
    }
  }




}