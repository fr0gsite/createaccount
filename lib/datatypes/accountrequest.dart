class AccountRequest {
  final String message;
  final String transactionid;

  AccountRequest({required this.message, required this.transactionid});

  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
        message: json['message'].toString(),
        transactionid: json['transactionid'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['transactionid'] = transactionid;
    return data;
  }

  static AccountRequest dummy() {
    return AccountRequest(message: "dummy", transactionid: "dummy");
  }
}
