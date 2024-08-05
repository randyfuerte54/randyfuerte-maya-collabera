import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randy_fuerte_technical_assessment/core/data/repositories/transaction_repository.dart';
import 'package:randy_fuerte_technical_assessment/core/helpers/helpers.dart';
import 'package:randy_fuerte_technical_assessment/core/layouts/spaced_column.dart';
import 'package:randy_fuerte_technical_assessment/core/theme/app_colors.dart';
import 'package:randy_fuerte_technical_assessment/core/widgets/dialogs/bottom_sheet.dart';
import 'package:randy_fuerte_technical_assessment/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';
import 'package:randy_fuerte_technical_assessment/generated/l10n.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amount = TextEditingController();

  late SendMoneyBloc sendMoneyBloc;
  double currentBalance = 0;

  @override
  void initState() {
    sendMoneyBloc = BlocProvider.of<SendMoneyBloc>(context);
    currentBalance =
        RepositoryProvider.of<TransactionRepository>(context).walletBalance;
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
          language.sendMoney,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: BlocConsumer<SendMoneyBloc, SendMoneyState>(
        bloc: sendMoneyBloc,
        listener: (context, state) {
          if (state is SendMoneySuccessState) {
            currentBalance = state.currentBalance;
            BottomSheetWidget().showBottomSheet(
              context: context,
              status: language.transferSuccess,
            );
          }

          if (state is SendMoneyErrorState) {
            currentBalance = state.currentBalance;
            BottomSheetWidget().showBottomSheet(
              context: context,
              status: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SpacedColumn(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SpacedColumn(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getAmountTextField(
                          language: language,
                        ),
                        getBalanceWidget(
                          language: language,
                        ),
                      ],
                    ),
                    getSubmitButton(language: language),
                  ],
                ),
              ),
              Center(
                child: Visibility(
                  visible: state is SendMoneyLoadingState,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getAmountTextField({
    required S language,
  }) {
    return TextFormField(
      controller: _amount,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction(
          (oldValue, newValue) {
            final text = newValue.text;

            return text.isEmpty
                ? newValue
                : double.tryParse(text) == null
                    ? oldValue
                    : newValue;
          },
        ),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColors.primaryColor,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
      validator: (value) {
        if (value.toString().isEmpty) {
          return language.requiredField;
        }

        final tempAmount = value;
        if (tempAmount != null) {
          final parsedAmount = double.parse(tempAmount);

          if (parsedAmount > currentBalance) {
            return language.insufficientBalance;
          }
        }
        return Helpers().isNumber(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        labelText: language.amount,
        labelStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
        hintText: '0.00',
        hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.black,
            ),
        fillColor: AppColors.white.withOpacity(0.1),
        filled: true,
      ),
    );
  }

  Widget getBalanceWidget({
    required S language,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        '${language.walletBalance} Php ${Helpers().formatBalance(
          balance: currentBalance.toString(),
        )}',
      ),
    );
  }

  Widget getSubmitButton({
    required S language,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        sendMoneyBloc.add(
          SendAmountEvent(
            amount: _amount.text,
          ),
        );
      },
      child: Text(
        language.submit,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
