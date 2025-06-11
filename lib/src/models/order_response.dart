class OrderResponse {
  final String? orderId;

  OrderResponse({this.orderId});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orderId: json['order']?['id'],
    );
  }
}
