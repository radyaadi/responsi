import 'package:flutter/material.dart';
import 'package:responsi/view/charaDetail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CharaList extends StatefulWidget {
  const CharaList({ Key? key }) : super(key: key);

  @override
  State<CharaList> createState() => _CharaListState();
}

class _CharaListState extends State<CharaList> {
  @override
  void initState() {
    super.initState();
    getJsonChara();
  }

  var chara = [];
  var charaCount = 0;
  bool isLoading = true;

  void getJsonChara() async {
    var response = await http
        .get(Uri.parse('https://api.genshin.dev/characters/'));
    setState(() {
      isLoading = false;
      chara = json.decode(response.body);
      charaCount = chara.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character List"),
        // automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: charaCount,
          itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context){
                return CharaDetail(
                  name: '${chara[index]}',
                  image: 'https://api.genshin.dev/characters/${chara[index]}/icon');
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
                        backgroundImage: NetworkImage('https://api.genshin.dev/characters/${chara[index]}/icon'),
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
                        Text(chara[index],
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