import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/domain/models/transaction_model.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  SendMoneyBloc({
    required this.transactionRepository,
  }) : super(SendMoneyInitial()) {
    on<SendAmountEvent>(_onSendAmountEvent);
  }

  TransactionRepository transactionRepository;

  FutureOr<void> _onSendAmountEvent(
    SendAmountEvent event,
    Emitter<SendMoneyState> emit,
  ) async {
    try {
      emit(SendMoneyLoadingState());

      transactionRepository.transactionId += 1;

      final response =
          await transactionRepository.sendMoney(amount: event.amount);

      final result = response.statusCode >= 200 && response.statusCode <= 302;
      if (result) {
        final transactionItem = TransactionModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );
        transactionRepository.transactions.add(transactionItem);
        transactionRepository.walletBalance -= double.parse(event.amount);
        emit(
          SendMoneySuccessState(
            transaction: transactionItem,
            currentBalance: transactionRepository.walletBalance,
          ),
        );
      } else {
        emit(
          SendMoneyErrorState(
            errorMessage: S.current.somethingWentWrongPleaseTryAgainLater,
            currentBalance: transactionRepository.walletBalance,
          ),
        );
      }
    } catch (e) {
      emit(
        SendMoneyErrorState(
          errorMessage: S.current.somethingWentWrongPleaseTryAgainLater,
          currentBalance: transactionRepository.walletBalance,
        ),
      );
    }
  }
}
