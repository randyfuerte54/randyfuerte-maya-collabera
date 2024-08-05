import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/features/transaction_history/presentation/blocs/bloc/transaction_history_bloc.dart';

import 'transaction_history_bloc_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<TransactionRepository>(),
  ],
)
void main() {
  late MockTransactionRepository mockTransactionRepository;
  late TransactionHistoryBloc transactionHistoryBloc;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    transactionHistoryBloc = TransactionHistoryBloc(
      transactionRepository: mockTransactionRepository,
    );
  });

  tearDown(() => transactionHistoryBloc.close());

  group(TransactionHistoryBloc, () {
    test('FetchTransactionHistoryEvent event props', () {
      // Assert
      const event = FetchTransactionHistoryEvent();

      // Act
      transactionHistoryBloc.add(event);

      final List<Object?> expectedProps = [];

      // Assert
      expect(event.props, expectedProps);
    });

    blocTest(
      'should emit FetchTransactionHistoryState when TransactionHistoryEvent is called',
      build: () => transactionHistoryBloc,
      act: (transactionHistoryBloc) => transactionHistoryBloc.add(
        const FetchTransactionHistoryEvent(),
      ),
      expect: () => <TransactionHistoryState>[
        TransactionHistoryLoadingState(),
        const FetchTransactionHistoryState(transactions: [])
      ],
    );
  });
}
