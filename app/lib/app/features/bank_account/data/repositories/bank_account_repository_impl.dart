import 'package:coopartilhar/app/features/bank_account/data/adapters/bank_account_adapter.dart';
import 'package:coopartilhar/app/features/bank_account/entities/bank_account.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/repositories/i_bank_account_repository.dart';
import 'package:core_module/core_module.dart';

class BankAccountRepositoryImpl implements IBankAccountRepository {
  final IRestClient restClient;
  BankAccountRepositoryImpl(this.restClient);

  @override
  Future<Output<List<BankAccountEntity>>> getAll() async {
    try {
      final response = await restClient.get(
        RestClientRequest(
          path: '/core/v1/bank_account',
        ),
      );
      final data = response.data;
      final List<BankAccountEntity> accounts = data.forEach(
          (bankAccountData) => BankAccountAdapter.fromJson(bankAccountData));
      await Future.delayed(const Duration(seconds: 2));
      return Right(accounts);
    } on BaseException catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(
          DefaultException(message: 'Ocorreu um erro inesperado.'));
    }
  }

  @override
  Future<Output<Unit>> save(BankAccountEntity bankAccount) async {
    try {
      await restClient.post(
        RestClientRequest(
          path: '/core/v1/bank-account',
          data: BankAccountAdapter.toJson(bankAccount),
        ),
      );
      return const Right(unit);
    } on BaseException catch (error) {
      return Left(DefaultException(message: error.message));
    } catch (_) {
      return const Left(DefaultException(message: 'Erro desconhecido'));
    }
  }
}
