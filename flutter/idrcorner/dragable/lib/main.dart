import 'package:flutter/material.dart';
import 'dragObject.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset posZebra = Offset(50, 50);
  Offset posCamel = Offset(170, 50);
  Offset posGiraffe = Offset(270, 50);
  Offset posHorse = Offset(400, 50);

  bool horseAcc = false;
  bool camelAcc = false;
  bool zebraAcc = false;
  bool giraffeAcc = false;

  int score=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg.jpg"), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Your Score : $score",
                  style: TextStyle(fontSize: 25, color: Colors.yellow),
                ),
                Container(
                  height: 130,
                  child: score==100 ? Text("YOU WIN", style: TextStyle(fontSize: 50, color: Colors.red),): Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildDragTarget(
                        "img/camel1.png", "img/camel2.png", "camel", camelAcc),
                    buildDragTarget(
                        "img/horse1.png", "img/horse2.png", "horse", horseAcc),
                    buildDragTarget("img/giraffe1.png", "img/giraffe2.png",
                        "giraffe", giraffeAcc),
                    buildDragTarget(
                        "img/zebra1.png", "img/zebra2.png", "zebra", zebraAcc),
                  ],
                )
              ],
            ),
            zebraAcc
                ? Container()
                : DragObject(
                    image: "img/zebra1.png",
                    position: posZebra,
                    dataNama: "zebra",
                  ),
            giraffeAcc
                ? Container()
                : DragObject(
                    image: "img/giraffe1.png",
                    position: posGiraffe,
                    dataNama: "giraffe",
                  ),
            camelAcc
                ? Container()
                : DragObject(
                    image: "img/camel1.png",
                    position: posCamel,
                    dataNama: "camel",
                  ),
            horseAcc
                ? Container()
                : DragObject(
                    image: "img/horse1.png",
                    position: posHorse,
                    dataNama: "horse",
                  ),
          ],
        ),
      ),
    );
  }

  DragTarget<String> buildDragTarget(image, image2, nama, acc) {
    return DragTarget(
      builder: (context, List<String> data, rj) {
        return acc
            ? Image.asset(
                image,
                width: 130,
                height: 130,
              )
            : data.isEmpty
                ? Image.asset(
                    image2,
                    width: 130,
                    height: 130,
                  )
                : Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      image2,
                      width: 130,
                      height: 130,
                    ),
                  );
      },
      onAccept: (data) {
        if (data == nama) {
          setState(() {
            acc = true;
            score+=25;
          });

          switch (nama) {
            case 'camel':
              setState(() {
                camelAcc = true;
              });
              break;
            case 'horse':
              setState(() {
                horseAcc = true;
              });
              break;
            case 'zebra':
              setState(() {
                zebraAcc = true;
              });
              break;
            case 'giraffe':
              setState(() {
                giraffeAcc = true;
              });
              break;
            default:
          }
        }
      },
    );
  }
}
