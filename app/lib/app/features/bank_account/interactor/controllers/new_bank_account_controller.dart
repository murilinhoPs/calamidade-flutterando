import 'package:coopartilhar/app/features/auth/interactor/controllers/login_controller_impl.dart';
import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/exceptions/new_bank_account_exception.dart';
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
  final bankNameController = TextEditingController(text: '');
  final agencyNumberController = TextEditingController(text: '');
  final accountNumberController = TextEditingController(text: '');
  final digitNumberController = TextEditingController(text: '');
  final pixKeyController = TextEditingController(text: '');

  Future<void> save() async {
    update(NewBankAccountLoadingState());
    if (!formKey.currentState!.validate()) {
      update(NewBankAccountInitialState());
      return;
    }

    final user = await userController.getUser();
    if (user == null) {
      update(NewBankAccountErrorState(
        exception: NewBankAccountException(
            message: 'Usuário não encontrado para cadastrar a conta'),
      ));
      return;
    }

    final bankAccountEntity = BankAccountEntity(
      -1,
      bankName: bankNameController.text,
      agency: agencyNumberController.text,
      account: accountNumberController.text,
      digit: digitNumberController.text,
      keyPix: pixKeyController.text,
      userId: user.id,
    );
    final response = await repository.save(bankAccountEntity);
    response.fold(
      (left) => update(NewBankAccountErrorState(exception: left)),
      (right) async {
        await bankAccountController.getAll(bankAccountEntity);
        formKey.currentState?.reset();
        update(NewBankAccountSuccessState(data: bankAccountEntity));
      },
    );
  }
}
