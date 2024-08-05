class TransactionModel {
  final String amount;
  final String date;
  final String transactionId;

  TransactionModel({
    required this.amount,
    required this.transactionId,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date,
        "transactionId": transactionId,
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json['amount'],
        transactionId: json['transactionId'],
        date: json['date'],
      );
}
