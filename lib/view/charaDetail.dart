import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:responsi/model/charaModel.dart';
import 'package:responsi/controller/request.dart';
// import 'package:url_launcher/url_launcher.dart';

class CharaDetail extends StatefulWidget {
  final String name;
  final String image;
  const CharaDetail({ Key? key, 
    required this.name,
    required this.image
  }) : super(key: key);

  @override
  State<CharaDetail> createState() => _CharaDetailState();
}

class _CharaDetailState extends State<CharaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _detailBody()
    );
  }

  Widget _detailBody() {
    return Container(
      child: FutureBuilder(
        future:  DataSource.instance.loadChara(widget.name),
        builder: (BuildContext context,
          AsyncSnapshot<dynamic> snapshot,) {
          
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CharaModel charaModel = CharaModel.fromJson(snapshot.data);
            return _buildSuccessSection(charaModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CharaModel data){
    String nation = '${data.nation}'.toLowerCase();
    String vision = '${data.vision}'.toLowerCase();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image.network(
                'https://api.genshin.dev/characters/${widget.name}/gacha-splash',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    'https://api.genshin.dev/nations/'+nation+'/icon',
                  ),
                ),
                Container(
                   width: 70,
                  height: 70,
                  child: Image.network(
                    'https://api.genshin.dev/elements/'+vision+'/icon',
                  ),
                ),
                Text('${data.name}',
                  style: TextStyle(
                  fontSize: 20.0
                  )
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var i=0; i<int.parse('${data.rarity}'); i++)
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
              ]
            ),
            SizedBox(height: 10),
            Text('${data.affiliation}',
              style: TextStyle(
              fontSize: 15.0
                )
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Text("${data.description}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 171, 176),
                  fontSize: 12.0,
                )
              )
            ),
          ]
        )
      )
    );
  }
}

