import 'package:flutter/material.dart';
import 'main.dart';

class KullaniciBilgileri extends StatefulWidget {
  @override
  _KullaniciBilgileriState createState() => _KullaniciBilgileriState();
}

class KullaniciDetay {
  static var name;
  static var surname;
  static var mailAddress;
  static var userName;
  static var lastLoginDate;
}

class _KullaniciBilgileriState extends State<KullaniciBilgileri> {
  @override
  void initState() {
    // TODO: implement initState
    name.text = KullaniciDetay.name;
    surname.text = KullaniciDetay.surname;
    mail.text = KullaniciDetay.mailAddress;
    username.text = KullaniciDetay.userName;
    lastLoginDate.text = KullaniciDetay.lastLoginDate;
  }

  var name = TextEditingController();
  var surname = TextEditingController();
  var username = TextEditingController();
  var mail = TextEditingController();
  var lastLoginDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text("Kullanıcı Bilgileri"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: name,
            ),
            TextField(
              controller: surname,
            ),
            TextField(
              controller: username,
            ),
            TextField(
              controller: mail,
            ),
            TextField(
              controller: lastLoginDate,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        backgroundColor: Colors.teal[800],
        label: Text("Güncelle"),
        icon: Icon(Icons.update),
      ),
    );
  }
}
