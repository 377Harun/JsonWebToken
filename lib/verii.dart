import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

void main() async {
  CityGetAll();
}

Future<List> CityGetAll() async {
  await TokenAl();
  var url = "https://api.archipoints.net/api/Users/GetAll";

  var res = await http.get(Uri.parse(url),
      headers: {"Authorization": Token.tokenType + " " + Token.token});

  Map veri = jsonDecode(res.body);

  print(veri);
}

TokenAl() async {
  var url = "https://api.archipoints.net/api/Users/Token";
  var veri = {
    "Username": "testuser",
    "Password": "123456",
  };

  var res = await http.post(Uri.parse(url), body: veri);

  var token = jsonDecode(res.body);

  Token.token = token["access_token"];
  Token.tokenType = token["token_type"];
  print(Token.token);
  print("***********************");
  print(Token.tokenType);
}

class Sehirler {
  String cityId;
  String countryId;
  String name;
  String isActive;

  Sehirler({this.cityId, this.countryId, this.name, this.isActive});

  factory Sehirler.fromJson(Map<String, dynamic> json) {
    return Sehirler(
      cityId: json["cityId"],
      countryId: json["countryId"],
      name: json["name"],
      isActive: json["isActive"],
    );
  }
}

Future<List<Sehirler>> SehirlerAl() async {
  var url = "https://api.archipoints.net/api/City/GetAll";

  var res = await http.get(Uri.parse(url));

  print((jsonDecode(res.body) as List).map((sendData) {
    return Sehirler.fromJson(sendData);
  }).toList());

  return (jsonDecode(res.body) as List).map((sendData) {
    return Sehirler.fromJson(sendData);
  }).toList();
}
