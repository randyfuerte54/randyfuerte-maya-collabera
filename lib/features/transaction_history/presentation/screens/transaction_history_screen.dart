import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randy_fuerte_technical_assessment/core/layouts/spaced_column.dart';
import 'package:randy_fuerte_technical_assessment/core/theme/app_colors.dart';
import 'package:randy_fuerte_technical_assessment/features/transaction_history/presentation/blocs/bloc/transaction_history_bloc.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late TransactionHistoryBloc transactionHistoryBloc;

  @override
  void initState() {
    transactionHistoryBloc = BlocProvider.of<TransactionHistoryBloc>(context);
    transactionHistoryBloc.add(const FetchTransactionHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff46848e),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          language.transactionHistory,
          style: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            color: AppColors.primaryColor,
          ).copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
        bloc: transactionHistoryBloc,
        builder: (context, transactionHistoryState) {
          if (transactionHistoryState is FetchTransactionHistoryState) {
            final transactions = transactionHistoryState.transactions;

            return transactionHistoryState.transactions.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: SpacedColumn(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                '${language.transactionId} ${transactions[index].transactionId}'),
                            Text(
                                '${language.amount} ${transactions[index].amount}'),
                            Text(
                                '${language.date} ${transactions[index].date}'),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(language.noTransactionHistory),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
