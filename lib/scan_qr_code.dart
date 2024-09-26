import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);

  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (urlController.text.isNotEmpty)
                QrImageView(
                  data: urlController.text,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Data',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Enter Your Data',
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Generate QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
