import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';

class BankAccountAdapter {
  static BankAccountEntity fromJson(Map<String, dynamic> json) {
    return BankAccountEntity(
      json['id'],
      bankName: json['bankName'],
      agency: json['agency'],
      account: json['account'],
      digit: json['digit'],
      keyPix: json['keyPix'],
      userId: json['userId'],
    );
  }

  static Map<String, dynamic> toJson(BankAccountEntity address) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankName'] = address.bankName;
    data['agency'] = address.agency;
    data['account'] = address.account;
    data['digit'] = address.digit;
    data['keyPix'] = address.keyPix;
    data['userId'] = address.userId;
    return data;
  }
}
