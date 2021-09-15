import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("หน้าหลัก", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString()); // [{คอมพิวเตอร์คืออะไร...}, {}, {}, {}]
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return MyBox(data[index]['title'], data[index]['subtitle'], data[index]['image_url'], data[index]['detail']);
            },
            itemCount: data.length,
          );
        },
        future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [ // หน้าแต่ละหน้ามีไอคอนอะไร?
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: "หน้าหลัก"),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white,), label: "ค้นหา"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts, color: Colors.white,), label: "ติดต่อเรา"),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      // color: Colors.blue[50],
      height: 150,
      decoration: BoxDecoration(
        // color: Colors.blue[20],
        image: DecorationImage(
          image: NetworkImage(image_url),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.50), BlendMode.darken
                  // Colors.white.withOpacity(0.20), BlendMode.lighten
                  ),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        // แกน y
        mainAxisAlignment: MainAxisAlignment.start,
        // แกน x
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 18,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(v1, v2, v3, v4)));
          }, child: Text("อ่านต่อ"))
        ],
      ),
    );
  }
}
