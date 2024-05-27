import 'package:coopartilhar/app/features/auth/interactor/controllers/login_controller_impl.dart';
import 'package:coopartilhar/app/features/auth/interactor/states/auth_state.dart';
import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/repositories/i_bank_account_repository.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/states/new_bank_states.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/widgets.dart';

class NewBankAccountController extends BaseController {
  final IBankAccountRepository repository;
  final LoginControllerImpl userController;
  final BankAccountController bankAccountController;

  NewBankAccountController({
    required this.repository,
    required this.userController,
    required this.bankAccountController,
  }) : super(NewBankAccountInitialState());

  final formKey = GlobalKey<FormState>();
  final bankNumberController = TextEditingController(text: '');
  final agencyNumberController = TextEditingController(text: '');
  final accountNumberController = TextEditingController(text: '');
  final digitNumberController = TextEditingController(text: '');
  final pixKeyController = TextEditingController(text: '');

  UserEntity user = UserEntity.init();

  Future<void> save() async {
    update(NewBankAccountLoadingState());

    if (!formKey.currentState!.validate()) {
      update(NewBankAccountInitialState());
      return;
    }

    if (userController.state case AuthSuccess(:final data)) {
      user = data;
    } //
    final bankAccountEntity = BankAccountEntity(
      -1,
      bankName: bankNumberController.text,
      agency: agencyNumberController.text,
      account: accountNumberController.text,
      digit: digitNumberController.text,
      keyPix: pixKeyController.text,
    );
    final response = await repository.save(bankAccountEntity);
    response.fold(
      (left) => update(NewBankAccountErrorState(exception: left)),
      (right) async {
        await bankAccountController.getAll(bankAccountEntity);
        update(NewBankAccountSuccessState(data: bankAccountEntity));
      },
    );
  }
}
