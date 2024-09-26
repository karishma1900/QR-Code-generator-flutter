import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                    _handleScanResult(result!);
                  }
                });
              },
              child: const Text('Open Scanner'),
            ),
            Text('Scan Result: $result'),
          ],
        ),
      ),
    );
  }

  void _handleScanResult(String result) {
    if (result.startsWith('http://') || result.startsWith('https://')) {
      _launchUrl(result);
    } else {
      _showResultDialog(context, result);
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showResultDialog(context, 'Could not launch $url');
    }
  }

  void _showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Scan Result'),
          content: Text(result),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
