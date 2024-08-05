import 'package:randy_fuerte_technical_assessment/features/send_money/domain/models/transaction_model.dart';
import 'package:http/http.dart' as http;

abstract class TransactionRepository {
  int transactionId = 0;
  List<TransactionModel> transactions = [];
  double walletBalance = 100;

  Future<http.Response> sendMoney({required String amount});
}
