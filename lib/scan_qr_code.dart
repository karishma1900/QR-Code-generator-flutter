import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScanQRCode(),
    );
  }
}

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = 'Scanned Data will appear here';

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
            Text(
              qrResult,
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the scanner page
                var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ),
                );

                // Check if the result is a string
                if (res is String) {
                  setState(() {
                    qrResult = res; // Update the result
                  });
                } else {
                  setState(() {
                    qrResult = 'Scan canceled or failed'; // Handle other cases
                  });
                }
              },
              child: const Text('Open Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleBarcodeScannerPage extends StatelessWidget {
  const SimpleBarcodeScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Call the scan method from the package
            String? scannedData = await SimpleBarcodeScanner.scan();

            // If the scan is successful, return the data
            if (scannedData != null) {
              Navigator.pop(context, scannedData); // Return scanned data to the previous page
            } else {
              Navigator.pop(context, 'Scan failed or canceled'); // Handle cases where the scan fails
            }
          },
          child: Text('Start Scanning'),
        ),
      ),
    );
  }
}
