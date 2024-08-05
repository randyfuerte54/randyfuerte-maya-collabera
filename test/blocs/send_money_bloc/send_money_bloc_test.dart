import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/domain/models/transaction_model.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

import '../../unit_test_utils.dart';
import 'send_money_bloc_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks(
  [
    MockSpec<TransactionRepository>(),
    MockSpec<TransactionModel>(),
    MockSpec<http.Response>(),
  ],
)
void main() {
  late MockTransactionRepository mockTransactionRepository;
  late SendMoneyBloc sendMoneyBloc;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    sendMoneyBloc = SendMoneyBloc(
      transactionRepository: mockTransactionRepository,
    );
  });

  tearDown(() => sendMoneyBloc.close());

  group(SendMoneyBloc, () {
    blocTest(
      'should emit SendMoneyErrorState when an exception occurs in SendAmountEvent is encountered',
      build: () => sendMoneyBloc,
      act: (sendMoneyBloc) async {
        await setupLocale();
        const event = SendAmountEvent(amount: '1');
        // List<MockTransactionModel> list = [];
        // final response = http.Response('', 200);
        when(
          mockTransactionRepository.sendMoney(amount: event.amount),
        ).thenThrow(throwsException);

        sendMoneyBloc.add(event);
      },
      expect: () => <SendMoneyState>[
        SendMoneyLoadingState(),
        SendMoneyErrorState(
          errorMessage: S.current.somethingWentWrongPleaseTryAgainLater,
          currentBalance: 0,
        )
      ],
    );

    blocTest(
      'should emit SendMoneySuccessState when SendAmountEvent is called',
      build: () => sendMoneyBloc,
      act: (bloc) async {
        await setupLocale();
        const event = SendAmountEvent(amount: '1');
        const expectedResponseBody =
            '{"amount": "1","date": "2024-08-05 19:06:40.701323","transactionId": "1","id": 101}';
        final response = http.Response(expectedResponseBody, 200);

        when(
          mockTransactionRepository.sendMoney(amount: event.amount),
        ).thenAnswer((_) async => response);

        bloc.add(event);
      },
      expect: () => [SendMoneyLoadingState(), isA<SendMoneySuccessState>()],
    );

    blocTest(
      'should emit SendMoneyErrorState when response status code is 500 when SendAmountEvent is called',
      build: () => sendMoneyBloc,
      act: (bloc) async {
        await setupLocale();
        const event = SendAmountEvent(amount: '1');
        const expectedResponseBody =
            '{"amount": "1","date": "2024-08-05 19:06:40.701323","transactionId": "1","id": 101}';
        final response = http.Response(expectedResponseBody, 500);

        when(
          mockTransactionRepository.sendMoney(amount: event.amount),
        ).thenAnswer((_) async => response);

        bloc.add(event);
      },
      expect: () => [
        SendMoneyLoadingState(),
        SendMoneyErrorState(
          errorMessage: S.current.somethingWentWrongPleaseTryAgainLater,
          currentBalance: 0,
        )
      ],
    );
  });
}
