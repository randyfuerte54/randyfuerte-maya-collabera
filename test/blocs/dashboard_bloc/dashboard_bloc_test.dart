import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';

import 'dashboard_bloc_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<TransactionRepository>(),
  ],
)
void main() {
  late MockTransactionRepository mockTransactionRepository;
  late DashboardBloc dashboardBloc;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    dashboardBloc = DashboardBloc(
      transactionRepository: mockTransactionRepository,
    );
  });

  tearDown(() => dashboardBloc.close());

  group(
    DashboardBloc,
    () {
      test('ToggleWalletBalanceEvent event props', () {
        // Assert
        const event = ToggleWalletBalanceEvent(isHidden: true);

        // Act
        dashboardBloc.add(event);

        final List<Object?> expectedProps = [event.isHidden];

        // Assert
        expect(event.props, expectedProps);
      });

      blocTest(
        'should emit ToggleWalletBalanceState when ToggleWalletBalanceEvent is called',
        build: () => dashboardBloc,
        act: (dashboardBloc) => dashboardBloc.add(
          const ToggleWalletBalanceEvent(isHidden: true),
        ),
        expect: () => <DashboardState>[
          DashboardLoadingState(),
          ToggleWalletBalanceState(
            isHidden: true,
            balance: 0,
          ),
        ],
      );
    },
  );
}
