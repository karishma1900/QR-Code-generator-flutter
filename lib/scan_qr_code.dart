import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = 'Scanned Data will appear here';
  bool isScanning = false;  // Added to track scanning status

  Future<void> scanQR() async {
    setState(() {
      isScanning = true;  // Set scanning status to true
    });
    
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      if (qrCode != '-1') {  // Check if the scan was not canceled
        setState(() {
          this.qrResult = qrCode;
        });
      } else {
        setState(() {
          this.qrResult = 'Scan canceled';
        });
      }
    } on PlatformException {
      setState(() {
        qrResult = 'Failed to read QR Code';
      });
    } catch (e) {
      setState(() {
        qrResult = 'Error: $e';
      });
    } finally {
      setState(() {
        isScanning = false;  // Reset scanning status
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            if (isScanning)  // Show a loading indicator while scanning
              CircularProgressIndicator(),
            Text(
              '$qrResult',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isScanning ? null : scanQR,  // Disable button while scanning
              child: Text('Scan Code'),
            ),
          ],
        ),
      ),
    );
  }
}
