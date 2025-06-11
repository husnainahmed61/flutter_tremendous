import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/order_response.dart';

enum TremendousEnv { sandbox, production }

class TremendousGift {
  final String apiKey;
  final TremendousEnv environment;

  TremendousGift({required this.apiKey, required this.environment});

  String get _baseUrl =>
      environment == TremendousEnv.sandbox
          ? 'https://testflight.tremendous.com/api/v2'
          : 'https://api.tremendous.com/api/v2';

  Future<OrderResponse> generateVoucher({
    required String fundingSourceId,
    required double amount,
    required String currencyCode,
    required String method,
    required String recipientName,
    required String recipientEmail,
    String? campaignId,
    List<String>? products,
  }) async {
    final url = Uri.parse('$_baseUrl/orders');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final reward = <String, dynamic>{
      'value': {
        'denomination': amount,
        'currency_code': currencyCode,
      },
      'delivery': {
        'method': method,
      },
      'recipient': {
        'name': recipientName,
        'email': recipientEmail,
      },
    };

    // Conditionally include campaignId or products
    if (campaignId != null) {
      reward['campaign_id'] = campaignId;
    }
    if (products != null && products.isNotEmpty) {
      reward['products'] = products;
    }
    if (campaignId == null && (products == null || products.isEmpty)) {
      throw ArgumentError('Either campaignId or products must be provided');
    }

    final body = jsonEncode({
      'payment': {
        'funding_source_id': fundingSourceId,
      },
      'reward': reward,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return OrderResponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      final errorMsg = error['errors']?['message'] ?? 'Unexpected error occurred';
      throw Exception('Tremendous API Error: $errorMsg');
    }
  }


  // Future<OrderResponse> generateVoucher({
  //   required String fundingSourceId,
  //   required double amount,
  //   required String currencyCode,
  //   required String method,
  //   required String recipientName,
  //   required String recipientEmail,
  //   required String campaignId,
  // }) async {
  //   final url = Uri.parse('$_baseUrl/orders');
  //   final headers = {
  //     'Authorization': 'Bearer $apiKey',
  //     'Content-Type': 'application/json',
  //   };
  //   final body = jsonEncode({
  //     'payment': {
  //       'funding_source_id': fundingSourceId,
  //     },
  //     'reward': {
  //       'value': {
  //         'denomination': amount,
  //         'currency_code': currencyCode,
  //       },
  //       'delivery': {
  //         'method': method,
  //       },
  //       'recipient': {
  //         'name': recipientName,
  //         'email': recipientEmail,
  //       },
  //       'campaign_id': campaignId,
  //     },
  //   });
  //
  //   final response = await http.post(url, headers: headers, body: body);
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return OrderResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     final error = jsonDecode(response.body);
  //     final errorMsg = error['errors']?['message'] ?? 'Unexpected error occurred';
  //     throw Exception('Tremendous API Error: $errorMsg');
  //   }
  // }
}
