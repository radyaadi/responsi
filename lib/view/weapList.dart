import 'package:flutter/material.dart';
import 'package:responsi/view/weapDetail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeaponList extends StatefulWidget {
  const WeaponList({ Key? key }) : super(key: key);

  @override
  State<WeaponList> createState() => _WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  @override
  void initState() {
    super.initState();
    getJsonWeapon();
  }

  var weapon = [];
  var weaponCount = 0;
  bool isLoading = true;

  void getJsonWeapon() async {
    var response = await http
        .get(Uri.parse('https://api.genshin.dev/weapons/'));
    setState(() {
      isLoading = false;
      weapon = json.decode(response.body);
      weaponCount = weapon.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weapons List"),
        // automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: weaponCount,
          itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return WeaponDetail(
                  name: '${weapon[index]}',
                  image: 'https://api.genshin.dev/weapons/${weapon[index]}/icon');
              }));
            },
            child: Card(
              child: Row(
                children:<Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage('https://api.genshin.dev/weapons/${weapon[index]}/icon'),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(weapon[index],
                          style: TextStyle(
                            fontSize: 18.0
                          )
                        ),
                        SizedBox(height: 8.0)
                      ]
                    )
                  )
                ]
              )
            )
          );
        },
      )
    );
  }
}