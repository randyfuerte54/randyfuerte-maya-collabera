import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/domain/models/transaction_model.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc({
    required this.transactionRepository,
  }) : super(TransactionHistoryInitial()) {
    on<FetchTransactionHistoryEvent>(_onFetchTransactionHistoryEvent);
  }

  final TransactionRepository transactionRepository;

  FutureOr<void> _onFetchTransactionHistoryEvent(
    FetchTransactionHistoryEvent event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    try {
      emit(TransactionHistoryLoadingState());

      final transactions = transactionRepository.transactions;

      emit(
        FetchTransactionHistoryState(
          transactions: transactions,
        ),
      );
    } catch (e) {
      emit(
        TransactionHistoryErrorState(
          errorMessage: S.current.somethingWentWrongPleaseTryAgainLater,
        ),
      );
    }
  }
}
