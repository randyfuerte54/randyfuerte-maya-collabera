part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {}

class ToggleWalletBalanceState extends DashboardState {
  final double balance;
  final bool isHidden;

  ToggleWalletBalanceState({
    required this.isHidden,
    required this.balance,
  });

  @override
  List<Object> get props => [isHidden];
}

final class DashboardInitialState extends DashboardState {
  @override
  List<Object?> get props => [];
}

final class DashboardLoadingState extends DashboardState {
  @override
  List<Object?> get props => [];
}

final class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}
