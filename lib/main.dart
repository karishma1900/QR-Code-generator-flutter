import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code/generate_qr_code.dart';
import 'package:qr_code/scan_qr_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner and Generator',
      debugShowCheckedModeBanner: false,
      
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     appBar: AppBar(title: Text('QR Code Scanner and Generator'),backgroundColor:Colors.blue,),
     body:Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          ElevatedButton(
            onPressed: (){
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScanQRCode()));
                
              });
            },child: Text('Scan Qr Code')),
            SizedBox(height: 40,),
            ElevatedButton(onPressed:(){
              setState(() {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GenerateQRCode()));
              });
            }, child:Text('Generate QR Code'))
        ]
      )
     )
    );
  }
}
