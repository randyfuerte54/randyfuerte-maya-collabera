import 'package:randy_fuerte_technical_assessment/core/config/url_constants.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/core/rest_service/rest_service.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/domain/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionRepositoryImpl extends TransactionRepository {
  @override
  Future<http.Response> sendMoney({required String amount}) async {
    final date = DateTime.now().toString();

    final sendMoney = TransactionModel(
      amount: amount,
      transactionId: transactionId.toString(),
      date: date,
    );
    return await RestService().post(
      UrlConstants.posts,
      body: sendMoney.toJson(),
    );
  }
}
