import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:responsi/model/weapModel.dart';
import 'package:responsi/controller/request.dart';
// import 'package:url_launcher/url_launcher.dart';

class WeaponDetail extends StatefulWidget {
  final String name;
  final String image;
  const WeaponDetail({ Key? key, 
    required this.name,
    required this.image
  }) : super(key: key);

  @override
  State<WeaponDetail> createState() => _WeaponDetailState();
}

class _WeaponDetailState extends State<WeaponDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _detailBody()
    );
  }

  Widget _detailBody() {
    return Container(
      child: FutureBuilder(
        future:  DataSource.instance.loadWeapon(widget.name),
        builder: (BuildContext context,
          AsyncSnapshot<dynamic> snapshot,) {
          
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            WeaponModel weaponModel = WeaponModel.fromJson(snapshot.data);
            return _buildSuccessSection(weaponModel);
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

  Widget _buildSuccessSection(WeaponModel data){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child:CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage('${widget.image}'),
                ),
              ),
            ),
            Text('${data.name}',
              style: TextStyle(
              fontSize: 18.0
              )
            ),
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
          ]
        )
      )
    );
  }
}

