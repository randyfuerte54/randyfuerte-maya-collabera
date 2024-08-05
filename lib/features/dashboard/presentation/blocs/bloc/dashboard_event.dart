part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class ToggleWalletBalanceEvent extends DashboardEvent {
  final bool isHidden;

  const ToggleWalletBalanceEvent({
    required this.isHidden,
  });

  @override
  List<Object?> get props => [isHidden];
}
