part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactionHistoryEvent extends TransactionHistoryEvent {
  const FetchTransactionHistoryEvent();

  @override
  List<Object> get props => [];
}
