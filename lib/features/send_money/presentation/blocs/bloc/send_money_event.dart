part of 'send_money_bloc.dart';

sealed class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();
}

class SendAmountEvent extends SendMoneyEvent {
  final String amount;

  const SendAmountEvent({
    required this.amount,
  });

  @override
  List<Object> get props => [amount];
}
