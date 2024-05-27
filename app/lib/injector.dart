import 'package:coopartilhar/app/features/accident/data/repositories/accident_repository_impl.dart';
import 'package:coopartilhar/app/features/accident/data/repositories/i_accident_repository.dart';
import 'package:coopartilhar/app/features/address/data/repositories/address_repository_impl.dart';
import 'package:coopartilhar/app/features/address/interactor/controllers/address_controller.dart';
import 'package:coopartilhar/app/features/address/interactor/controllers/new_address_controller.dart';
import 'package:coopartilhar/app/features/address/interactor/repositories/i_address_repository.dart';
import 'package:coopartilhar/app/features/ask_help/interactor/repositories/i_new_ask_help_repository.dart';
import 'package:coopartilhar/app/features/ask_help/data/repositories/new_ask_help_repository_impl.dart';
import 'package:coopartilhar/app/features/ask_help/interactor/controllers/ask_help_controller.dart';
import 'package:coopartilhar/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coopartilhar/app/features/auth/interactor/controllers/login_controller_impl.dart';
import 'package:coopartilhar/app/features/auth/interactor/repositories/i_auth_repository.dart';
import 'package:coopartilhar/app/features/bank_account/data/repositories/bank_account_repository_impl.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/controllers/new_bank_account_controller.dart';
import 'package:coopartilhar/app/features/bank_account/interactor/repositories/i_bank_account_repository.dart';
import 'package:coopartilhar/app/features/file/data/repositories/file_repository_impl.dart';
import 'package:coopartilhar/app/features/file/data/repositories/i_file_repository.dart';
import 'package:coopartilhar/app/features/check_affiliated/data/check_affiliated_repository_impl.dart';
import 'package:coopartilhar/app/features/check_affiliated/data/i_check_affiliated_repository.dart';
import 'package:coopartilhar/app/features/check_affiliated/interactor/check_affiliated_controller.dart';
import 'package:coopartilhar/app/features/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'package:coopartilhar/app/features/forgot_password/interactor/controllers/forgot_password_controller.dart';
import 'package:coopartilhar/app/features/forgot_password/interactor/repositories/i_forgot_password_repository.dart';
import 'package:coopartilhar/app/features/home/data/repositories/home_repository_impl.dart';
import 'package:coopartilhar/app/features/home/interactor/controllers/home_controller.dart';
import 'package:coopartilhar/app/features/home/interactor/repositories/i_home_repository.dart';
import 'package:coopartilhar/app/features/onboarding/data/onboarding_repository_impl.dart';
import 'package:coopartilhar/app/features/onboarding/interactor/controllers/onboarding_controller.dart';
import 'package:coopartilhar/app/features/onboarding/interactor/interface/i_onboarding_repository.dart';
import 'package:coopartilhar/app/features/register/interactor/controllers/register_controller.dart';
import 'package:coopartilhar/app/features/register/interactor/repositories/i_register_repository.dart';
import 'package:coopartilhar/app/features/register/data/repositories/register_assisted_repository_impl.dart';
import 'package:coopartilhar/app/features/request_details/interactor/repositories/i_request_details_repository.dart';
import 'package:coopartilhar/app/features/request_details/data/repositories/request_details_repository_impl.dart';
import 'package:coopartilhar/app/features/request_details/interactor/controllers/request_details_controller.dart';
import 'package:coopartilhar/app/features/reset_password/data/repositories/reset_password_repository_impl.dart';
import 'package:coopartilhar/app/features/reset_password/interactor/controllers/reset_password_controller.dart';
import 'package:coopartilhar/app/features/reset_password/interactor/repositories/i_reset_password_repository.dart';
import 'package:core_module/core_module.dart';

final injector = AutoInjector(
  on: (injector) {
    injector.addInjector(coreModule);

    injector.addLazySingleton<ILocationService>(LocationService.new);
    injector.addLazySingleton(PermissionHandler.new);
    injector.add(NewAddressController.new);
    injector.addLazySingleton<IAddressRepository>(AddressRepositoryImpl.new);
    injector.addLazySingleton(AddressController.new);
    injector.addLazySingleton<IBankAccountRepository>(
        BankAccountRepositoryImpl.new);
    injector.addLazySingleton(BankAccountController.new);
    injector.addLazySingleton(NewBankAccountController.new);

    injector.add(HomeController.new);
    injector.add<IHomeRepository>(HomeRepositoryImpl.new);
    injector.addSingleton<IRegisterRepository>(RegisterRepositoryImpl.new);
    injector.addSingleton<RegisterController>(RegisterController.new);
    injector.add<IOnboardingRepository>(OnboardingRepositoryImpl.new);
    injector.addSingleton<IAuthRepository>(AuthRepositoryImpl.new);
    injector.addLazySingleton<OnboardingController>(OnboardingController.new);
    injector.addLazySingleton<LoginControllerImpl>(LoginControllerImpl.new);

    injector.addLazySingleton<IAccidentRepository>(AccidentRepositoryImpl.new);
    injector.addLazySingleton<IFileRepository>(FileRepositoryImpl.new);
    injector
        .addLazySingleton<INewAskHelpRepository>(NewAskHelpRepositoryImpl.new);
    injector.add<AskHelpController>(AskHelpController.new);
    injector.addLazySingleton<ICheckAffiliatedRepository>(
        CheckAffiliatedRepositoryImpl.new);
    injector.addLazySingleton<CheckAffiliatedController>(
        CheckAffiliatedController.new);
    injector.addLazySingleton<IRequestDetailsRepository>(
        RequestDetailsRepositoryImpl.new);
    injector.addLazySingleton<RequestDetailsController>(
        RequestDetailsController.new);

    injector.addLazySingleton<IForgotPasswordRepository>(
        ForgotPasswordRepositoryImpl.new);
    injector.addLazySingleton(ForgotPasswordController.new);

    injector.addLazySingleton<IResetPasswordRepository>(
        ResetPasswordRepositoryImpl.new);
    injector.addLazySingleton(ResetPasswordController.new);

    injector.commit();
  },
);
