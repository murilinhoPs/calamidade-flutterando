import 'package:coopartilhar/app/(public)/bank_account/new_bank_account/widgets/text_input_information.dart';
import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:coopartilhar/app/features/bank_account/entities/new_bank_account_navigation.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/new_bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/states/new_bank_states.dart';
import 'package:coopartilhar/injector.dart';
import 'package:coopartilhar/routes.dart';
import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class NewBankAccountPage extends StatefulWidget {
  final String title;
  final String buttonTitle;
  const NewBankAccountPage({
    super.key,
    this.title = 'Cadastrar Conta Bancária',
    this.buttonTitle = 'Próximo',
  });

  @override
  State<NewBankAccountPage> createState() => _NewBankAccountPageState();
}

class _NewBankAccountPageState extends State<NewBankAccountPage> {
  final controller = injector.get<NewBankAccountController>();
  late NewBankAccountNavigation navigationData;

  @override
  void initState() {
    navigationData = Routefly.query.arguments != null
        ? Routefly.query.arguments as NewBankAccountNavigation
        : NewBankAccountNavigation();

    controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState(:final BankAccountEntity data) => {
          Alerts.showSuccess(context, 'Conta adicionada com sucesso!'),
          navigationData.isRegisterFlow
              ? Routefly.navigate(
                  routePaths.successState,
                )
              : Routefly.pop(context)
        },
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.message),
      _ => null
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = CoopartilharColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodySmall?.copyWith(color: colors.textColor2);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(navigationData.title,
            style: textTheme.displayLarge?.copyWith(color: colors.textColor)),
        leading: IconButton(
            icon: Icon(UIcons.regularStraight.angle_small_left),
            onPressed: () => Routefly.pop(context)),
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(
            child: Image(
              image: CooImages.cooBackgroundDetails,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldInformation(
                        text: 'Identificação do Banco',
                      ),
                      TextFormField(
                        controller: controller.bankNumberController,
                        decoration: InputDecoration(
                          hintText: navigationData.bankHintText,
                          hintStyle: hintStyle,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Identificação do Banco não pode estar vazio';
                          }
                          return null;
                        },
                      ),
                      const TextFieldInformation(text: 'Agência'),
                      TextFormField(
                        controller: controller.agencyNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: navigationData.agencyHintText,
                          hintStyle: hintStyle,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Não pode estar vazio';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldInformation(text: 'Conta'),
                                TextFormField(
                                  controller:
                                      controller.accountNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: navigationData.accountHintText,
                                    hintStyle: hintStyle,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Não pode estar vazio';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldInformation(text: 'Digíto'),
                                TextFormField(
                                  controller: controller.digitNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText:
                                        navigationData.accountDigitHintText,
                                    hintStyle: hintStyle,
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Não pode estar vazia';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const TextFieldInformation(text: 'Chave PIX da Conta'),
                      TextFormField(
                        controller: controller.pixKeyController,
                        decoration: InputDecoration(
                          hintText: navigationData.pixKeyHintText,
                          hintStyle: hintStyle,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Chave PIX não pode estar vazia';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: CooButton.primary(
          label: navigationData.buttonTitle,
          onPressed: controller.save,
        ),
      ),
    );
  }
}
