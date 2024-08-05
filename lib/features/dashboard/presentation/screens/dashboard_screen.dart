import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:randy_fuerte_technical_assessment/core/helpers/helpers.dart';
import 'package:randy_fuerte_technical_assessment/core/layouts/spaced_column.dart';
import 'package:randy_fuerte_technical_assessment/core/layouts/spaced_row.dart';
import 'package:randy_fuerte_technical_assessment/core/theme/app_colors.dart';
import 'package:randy_fuerte_technical_assessment/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';

import 'package:randy_fuerte_technical_assessment/features/send_money/presentation/screens/send_money_screen.dart';
import 'package:randy_fuerte_technical_assessment/features/transaction_history/presentation/screens/transaction_history_screen.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardBloc dashboardBloc;
  bool isBalanceHidden = false;

  @override
  void initState() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    dashboardBloc.add(
      const ToggleWalletBalanceEvent(
        isHidden: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SpacedColumn(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<DashboardBloc, DashboardState>(
                  bloc: dashboardBloc,
                  builder: (context, dashboardState) {
                    if (dashboardState is ToggleWalletBalanceState) {
                      return SpacedColumn(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          getWalletBalanceWidget(
                            language: language,
                            dashboardState: dashboardState,
                          ),
                          getSendMoneyButton(
                            language: language,
                            dashboardState: dashboardState,
                          ),
                        ],
                      );
                    }

                    if (dashboardState is DashboardErrorState) {
                      return Center(
                        child: Text(
                          language.somethingWentWrongPleaseTryAgainLater,
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                getTransactionHistoryButton(
                  language: language,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWalletBalanceWidget({
    required S language,
    required ToggleWalletBalanceState dashboardState,
  }) {
    final balance = Helpers().formatBalance(
      balance: dashboardState.balance.toString(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            language.walletBalance,
            style: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          SpacedRow(
            spacing: 10,
            children: [
              Text(
                'Php ${dashboardState.isHidden ? Helpers().concealString(
                    amount: balance,
                  ) : balance}',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: () {
                  dashboardBloc.add(
                    ToggleWalletBalanceEvent(
                      isHidden: !dashboardState.isHidden,
                    ),
                  );
                },
                child: Icon(
                  dashboardState.isHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSendMoneyButton({
    required S language,
    required ToggleWalletBalanceState dashboardState,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 250),
            type: PageTransitionType.fade,
            child: const SendMoneyScreen(),
          ),
        ).then(
          (value) {
            dashboardBloc.add(
              ToggleWalletBalanceEvent(
                isHidden: dashboardState.isHidden,
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero.copyWith(left: 15),
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
      ),
      child: Text(
        language.sendMoney,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.normal,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget getTransactionHistoryButton({
    required S language,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 250),
            type: PageTransitionType.fade,
            child: const TransactionHistoryScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero.copyWith(left: 15),
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
      ),
      child: Text(
        language.transactionHistory,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.normal,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
