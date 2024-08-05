part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

final class TransactionHistoryInitial extends TransactionHistoryState {}

class FetchTransactionHistoryState extends TransactionHistoryState {
  final List<TransactionModel> transactions;

  const FetchTransactionHistoryState({
    required this.transactions,
  });

  @override
  List<Object> get props => [transactions];
}

final class TransactionHistoryErrorState extends TransactionHistoryState {
  final String errorMessage;

  const TransactionHistoryErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

final class TransactionHistoryLoadingState extends TransactionHistoryState {
  @override
  List<Object> get props => [];
}
