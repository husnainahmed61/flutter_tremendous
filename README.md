# flutter\_tremendous

A Flutter/Dart package to easily integrate with the [Tremendous](https://www.tremendous.com) Gift Card API, allowing you to send digital rewards and vouchers programmatically.

## Features

* Generate digital vouchers via the Tremendous API
* Supports both **sandbox** and **production** environments
* Simple configuration and usage
* Handles response parsing and basic error handling

## Getting Started

Add this to your `pubspec.yaml` dependencies:

```
dependencies:
  flutter_tremendous:
    git:
      url: https://github.com/husnainahmed61/flutter_tremendous.git
```

> Replace with your actual GitHub repo URL.

## Installation

1. Run `flutter pub get` or `dart pub get`
2. Import the package:

```
import 'package:flutter_tremendous/flutter_tremendous.dart';
```

## Usage

### 1. Initialize the Client

```
final tremendous = TremendousGift(
  apiKey: 'YOUR_API_KEY',
  environment: TremendousEnv.production, // or TremendousEnv.sandbox
);
```

### 2. Generate Voucher (with campaignId or product list)

You can either pass a `campaignId` **or** a list of `product` IDs:

#### a. Using `campaignId`:

```
final response = await tremendous.generateVoucher(
  fundingSourceId: 'BALANCE',
  amount: 100.0,
  currencyCode: 'EUR',
  method: 'EMAIL',
  recipientName: 'Jane Doe',
  recipientEmail: 'jane@example.com',
  campaignId: 'XD58VCFBQIP4',
);

print('Voucher Order ID: ${response.orderId}');
```

#### b. Using `products`:

```
final response = await tremendous.generateVoucher(
  fundingSourceId: 'BALANCE',
  amount: 50.0,
  currencyCode: 'USD',
  method: 'EMAIL',
  recipientName: 'Jane Doe',
  recipientEmail: 'jane@example.com',
  products: [
    'OKMHM2X2OHYV',
    'KV934TZ93NQM',
    'ET0ZVETV5ILN',
    'Q24BD9EZ332JT',
    'TBAJH7YLFVS5',
  ],
);
```
> ⚠️ **Note**: You must provide either a valid `campaignId` or a list of `products`. If both are omitted, an error will be thrown.


## Environments

| Environment | Base URL                                                               |
| ----------- | ---------------------------------------------------------------------- |
| Sandbox     | [https://testflight.tremendous.com](https://testflight.tremendous.com) |
| Production  | [https://api.tremendous.com](https://api.tremendous.com)               |

Ensure you use the correct API key corresponding to the selected environment.

## Error Handling

If the API call fails, an exception will be thrown with a detailed error message.

```
try {
  final response = await tremendous.generateVoucher(...);
} catch (e) {
  print('Failed to generate voucher: $e');
}
```

## Model

The `OrderResponse` model contains the order ID returned by the Tremendous API.

```
class OrderResponse {
  final String? orderId;

  OrderResponse({this.orderId});
}
```

## Requirements

* Dart SDK: >=2.17.0 <4.0.0
* Flutter-compatible project
* Valid API key and Campaign ID from Tremendous

## Contributing

Pull requests are welcome. For significant changes, open an issue to discuss improvements or new features first.

## License

MIT License. See LICENSE for details.
