import 'package:flutter/material.dart';
import 'package:responsi/view/charaList.dart';
import 'package:responsi/view/weapList.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg'),
              fit: BoxFit.cover
          )
        ),
        child: Center(
        child: Column(
          children:[
            SizedBox(height: 100),
            Container(
              width: 150,
              height: 150,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 253, 253, 253),
                backgroundImage: NetworkImage('https://24wallpapers.com/app-gateway/wallpaper-uploads/wallpapers/28_12_2021/1640677141329_5.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 80, right: 80),
              child: Column(
                children: [
                  SizedBox(height: 200),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CharaList();
                      }));
                    },
                    child: Text('Karakter'),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return WeaponList();
                      }));
                    },
                    child: Text('Weapon'),
                  )
                ]
              )
            )
          ],
        )
      ),
      )
    );
  }
}