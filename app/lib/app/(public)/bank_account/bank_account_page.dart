import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/states/bank_states.dart';
import 'package:coopartilhar/injector.dart';
import 'package:coopartilhar/routes.dart';
import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class BankAccountScreenArguments {
  final BankAccountEntity? bankAccount;

  BankAccountScreenArguments(this.bankAccount);
}

class BankAccountPage extends StatefulWidget {
  final String title;

  const BankAccountPage({super.key, this.title = 'Selecionar Conta Bancária'});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final BankAccountController controller =
      injector.get<BankAccountController>();

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    // controller.dispose();
    super.dispose();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() => Routefly.pop(context),
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.message),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(UIcons.regularStraight.angle_small_left),
          onPressed: () {
            Routefly.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, _) {
            if (state is BankAccountLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const Image(image: CooImages.cooBackgroundDetails),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state is BankAccountLoadedState)
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.bankAccounts.length,
                            itemBuilder: (context, i) {
                              final BankAccountEntity bankAccount =
                                  state.bankAccounts[i];
                              final bool isSelected =
                                  state.selectedBankAccount?.id ==
                                          bankAccount.id ||
                                      false;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: CardBankAccount(
                                  isSelected: isSelected,
                                  onTap: () =>
                                      controller.changeBankAccount(bankAccount),
                                  bankName: '${bankAccount.bankName}',
                                  accountLabel:
                                      'Ag. ${bankAccount.agency}, Conta: ${bankAccount.account}-${bankAccount.digit}',
                                  keyPix: '${bankAccount.keyPix}',
                                ),
                              );
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CooButton(
                              label: 'Confirmar',
                              onPressed: () {
                                if (state is BankAccountLoadedState &&
                                    state.selectedBankAccount != null) {
                                  Routefly.pop(context);
                                }
                              },
                              enable: (state is BankAccountLoadedState &&
                                  state.selectedBankAccount != null),
                            ),
                            const SizedBox(height: 10),
                            CooButton.outline(
                              label: 'Cadastrar Conta Bancária',
                              onPressed: () => Routefly.push(
                                routePaths.bankAccount.newBankAccount,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
