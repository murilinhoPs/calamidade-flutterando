import 'package:coopartilhar/app/(public)/bank_account/new_bank_account/widgets/text_input_information.dart';
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
  late VoidCallback onContinue;
  late String title;
  late String buttonTitle;

  @override
  void initState() {
    onContinue = Routefly.query.arguments?['callback'] ?? () {};
    title = Routefly.query.arguments?['title'] ?? widget.title;
    buttonTitle =
        Routefly.query.arguments?['buttonTitle'] ?? widget.buttonTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CoopartilharColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodySmall?.copyWith(color: colors.textColor2);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(title,
            style: textTheme.displayLarge?.copyWith(color: colors.textColor)),
        leading: IconButton(
            icon: Icon(UIcons.regularStraight.angle_small_left),
            onPressed: () => Routefly.pop(context)),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldInformation(text: 'Identificação do Banco*'),
                TextFormField(
                  //controller: controller.identificationController,
                  decoration: InputDecoration(
                    hintText: 'Insira o título para a solicitação',
                    hintStyle: hintStyle,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Identificação do Banco não pode estar vazio';
                    }
                    return null;
                  },
                ),
                const TextFieldInformation(text: 'Agência*'),
                TextFormField(
                  // controller: controller.addressController,
                  decoration: InputDecoration(
                    hintText: 'Insira a agência bancária do Assistido',
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
                          const TextFieldInformation(text: 'Conta*'),
                          TextFormField(
                            // controller: controller.addressController,
                            decoration: InputDecoration(
                              hintText: 'Insira a Conta',
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
                          const TextFieldInformation(text: 'Digíto*'),
                          TextFormField(
                            //controller: controller.ufController,
                            decoration: InputDecoration(
                              hintText: 'Insira o Dígito',
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
                const TextFieldInformation(text: 'Chave PIX da Conta*'),
                TextFormField(
                  //controller: controller.ufController,
                  decoration: InputDecoration(
                    hintText: 'Insira a chave PIX do Assistido',
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
      bottomNavigationBar: SafeArea(
        child: CooButton.primary(
          label: buttonTitle,
          onPressed: onContinue,
        ),
      ),
    );
  }
}
