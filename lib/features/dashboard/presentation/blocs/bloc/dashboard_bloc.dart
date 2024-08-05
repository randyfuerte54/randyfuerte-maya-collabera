import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.transactionRepository})
      : super(DashboardInitialState()) {
    on<ToggleWalletBalanceEvent>(_onToggleWalletBalanceEvent);
  }
  final TransactionRepository transactionRepository;

  FutureOr<void> _onToggleWalletBalanceEvent(
    ToggleWalletBalanceEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardLoadingState());
    emit(
      ToggleWalletBalanceState(
        isHidden: event.isHidden,
        balance: transactionRepository.walletBalance,
      ),
    );
  }
}
