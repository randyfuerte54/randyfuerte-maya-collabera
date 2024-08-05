import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randy_fuerte_technical_assessment/core/theme/app_colors.dart';
import 'package:randy_fuerte_technical_assessment/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:randy_fuerte_technical_assessment/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository_impl.dart';
import 'package:randy_fuerte_technical_assessment/features/transaction_history/presentation/blocs/bloc/transaction_history_bloc.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

class SendMoneyApp extends StatefulWidget {
  const SendMoneyApp({super.key});

  @override
  State<SendMoneyApp> createState() => _SendMoneyAppState();
}

class _SendMoneyAppState extends State<SendMoneyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TransactionRepository>(
      create: (context) => TransactionRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              transactionRepository:
                  RepositoryProvider.of<TransactionRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SendMoneyBloc(
              transactionRepository:
                  RepositoryProvider.of<TransactionRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TransactionHistoryBloc(
              transactionRepository:
                  RepositoryProvider.of<TransactionRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Send Money App',
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Poppins, sans-serif',
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.primaryColor,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppColors.black,
            ),
            textTheme: TextTheme(
              displayMedium: GoogleFonts.poppins(
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              titleMedium: GoogleFonts.poppins(
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              displaySmall: GoogleFonts.poppins(
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const DashboardScreen(),
        ),
      ),
    );
  }
}
