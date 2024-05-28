import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:core_module/core_module.dart';

class NewBankAccountInitialState extends InitialState {}

class NewBankAccountLoadingState extends LoadingState {}

class NewBankAccountSuccessState extends SuccessState<BankAccountEntity> {
  const NewBankAccountSuccessState({
    required super.data,
  });
}

class NewBankAccountErrorState<NewBankAccountException> extends ErrorState {
  NewBankAccountErrorState({required super.exception});
}
