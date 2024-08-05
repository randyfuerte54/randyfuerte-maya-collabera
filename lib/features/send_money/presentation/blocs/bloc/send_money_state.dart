part of 'send_money_bloc.dart';

sealed class SendMoneyState extends Equatable {
  const SendMoneyState();

  @override
  List<Object?> get props => [];
}

final class SendMoneyInitial extends SendMoneyState {}

final class SendMoneyLoadingState extends SendMoneyState {
  @override
  List<Object?> get props => [];
}

final class SendMoneySuccessState extends SendMoneyState {
  final TransactionModel? transaction;
  final double currentBalance;

  const SendMoneySuccessState({
    required this.transaction,
    required this.currentBalance,
  });

  @override
  List<Object?> get props => [
        transaction,
        currentBalance,
      ];
}

final class SendMoneyErrorState extends SendMoneyState {
  final String errorMessage;
  final double currentBalance;

  const SendMoneyErrorState({
    required this.errorMessage,
    required this.currentBalance,
  });

  @override
  List<Object> get props => [
        errorMessage,
        currentBalance,
      ];
}
