import 'package:flutter/material.dart';
import 'package:flutter_tremendous/flutter_tremendous.dart';

void main() {
  runApp(const TremendousDemoApp());
}

class TremendousDemoApp extends StatelessWidget {
  const TremendousDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tremendous Gift Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TremendousHomePage(),
    );
  }
}

class TremendousHomePage extends StatefulWidget {
  const TremendousHomePage({super.key});

  @override
  State<TremendousHomePage> createState() => _TremendousHomePageState();
}

class _TremendousHomePageState extends State<TremendousHomePage> {
  final _tremendous = TremendousGift(
    apiKey: 'YOUR API KEY HERE',
    environment: TremendousEnv.sandbox,
  );

  String? _result;

  Future<void> _sendVoucher() async {
    setState(() => _result = 'Sending voucher...');

    try {
      final response = await _tremendous.generateVoucher(
        fundingSourceId: 'BALANCE',
        amount: 50.0,
        currencyCode: 'USD',
        method: 'EMAIL',
        recipientName: 'Jane Doe',
        recipientEmail: 'husnainahmed61@gmail.com',
        // Either use a campaignId OR a list of product IDs
        products: [
          'OKMHM2X2OHYV',
        ],
      );
      setState(() => _result = 'Voucher created: ${response.orderId}');
    } catch (e) {
      setState(() => _result = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tremendous Gift Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _sendVoucher,
              child: const Text('Send Test Voucher'),
            ),
            const SizedBox(height: 16),
            if (_result != null)
              Text(_result!, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
