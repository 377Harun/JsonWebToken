import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:tokenileverial/KullaniciBilgiler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Index {
  static int sira;
}

class Token {
  static String token = "";
  static String tokenType = "";
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
}

Future<List> CityGetAll() async {
  await TokenAl();

  var url = "https://api.archipoints.net/api/Users/GetAll";

  var res = await http.get(Uri.parse(url),
      headers: {"Authorization": Token.tokenType + " " + Token.token});

  Map veri = jsonDecode(res.body);

  var users = veri["users"];

  print(res.body);

  return users;
}

class _MyAppState extends State<MyApp> {
  bool aramayapiliyormu = false;

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[800],
            title: aramayapiliyormu
                ? TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Aramak için veri girin",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Colors.white)),
                  )
                : Text("Kullanıcılar"),
            actions: [
              aramayapiliyormu
                  ? IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          aramayapiliyormu = false;
                        });
                        ;
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          aramayapiliyormu = true;
                        });
                      },
                    ),
            ],
          ),
          body: FutureBuilder<List>(
            future: CityGetAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, indeks) {
                    return Column(
                      children: [
                        ListTile(
                          title: GestureDetector(
                            onTap: () {
                              setState(() {
                                Index.sira = indeks;
                                KullaniciDetay.name =
                                    snapshot.data[indeks]["name"];
                                KullaniciDetay.surname =
                                    snapshot.data[indeks]["surname"];
                                KullaniciDetay.userName =
                                    snapshot.data[indeks]["userName"];
                                KullaniciDetay.mailAddress =
                                    snapshot.data[indeks]["mailAddress"];
                                KullaniciDetay.lastLoginDate =
                                    snapshot.data[indeks]["lastLoginDate"];
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          KullaniciBilgileri()));
                            },
                            child: Text(
                              " ${snapshot.data[indeks]["name"]}  ${snapshot.data[indeks]["surname"]}",
                            ),
                          ),
                          leading: Icon(
                            Icons.account_box_sharp,
                            color: Colors.blueGrey[800],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Null;
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.teal[800],
                ));
              }
            },
          ),
          floatingActionButton: aramayapiliyormu
              ? Container()
              : FloatingActionButton.extended(
                  backgroundColor: Colors.teal[800],
                  label: Text("Ekle"),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    CityGetAll();
                  },
                )),
    );
  }
}
