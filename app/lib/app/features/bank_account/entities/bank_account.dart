import 'package:core_module/core_module.dart';

class BankAccountEntity extends Entity {
  String? bankName;
  String? agency;
  String? account;
  String? digit;
  String? keyPix;
  int? userId;

  BankAccountEntity(
    super.id, {
    this.bankName,
    this.agency,
    this.account,
    this.digit,
    this.keyPix,
    this.userId,
  });
}
