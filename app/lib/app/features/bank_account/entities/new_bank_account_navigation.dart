import 'package:core_module/core_module.dart';

class NewBankAccountNavigation extends Entity {
  final String title;
  final String bankHintText;
  final String agencyHintText;
  final String accountHintText;
  final String accountDigitHintText;
  final String pixKeyHintText;
  final String buttonTitle;
  final bool isRegisterFlow;

  NewBankAccountNavigation({
    this.title = 'Cadastrar Conta Bancária',
    this.bankHintText = 'Informe o Banco',
    this.agencyHintText = 'Informe a agência',
    this.accountHintText = 'Insira a conta',
    this.accountDigitHintText = 'Insira o Digito',
    this.pixKeyHintText = 'Insira a chave PIX',
    this.buttonTitle = 'Confirmar',
    this.isRegisterFlow = false,
  }) : super(-1);
}
