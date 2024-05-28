import 'package:coopartilhar/app/(public)/auth/register/widgets/non_editable_register_item.dart';
import 'package:coopartilhar/app/(public)/auth/register/widgets/register_item_field.dart';
import 'package:coopartilhar/app/features/check_affiliated/interactor/check_affiliated_controller.dart';
import 'package:coopartilhar/app/features/register/interactor/controllers/register_controller.dart';
import 'package:coopartilhar/injector.dart';
import 'package:coopartilhar/routes.dart';
import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = injector.get<RegisterController>();
  final userController = injector.get<CheckAffiliatedController>();

  UserEntity user = UserEntity.init();

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);

    if (userController.state case SuccessState(:final data)) {
      setState(() {
        user = data as UserEntity;
      });
    }
  }

  void listener() {
    return switch (controller.value) {
      SuccessState() => Routefly.push(
          routePaths.address.newAddress,
          arguments: {
            'isRegister': true,
            'title': 'Confirmar Endereço',
          },
        ),
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.message),
      _ => null,
    };
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CoopartilharColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom + 20;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Concluir cadastro',
            style: textTheme.displayLarge?.copyWith(color: colors.textColor)),
        leading: IconButton(
            icon: Icon(UIcons.regularStraight.angle_small_left),
            onPressed: Navigator.of(context).pop),
        surfaceTintColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: CooImages.cooBackgroundDetails,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter),
          ),
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              if (controller.value is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 24, right: 24),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: keyboardHeight > 0
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 30),
                            NonEditableRegisterItem(
                              title: 'Nome completo',
                              value: user.name,
                            ),
                            const SizedBox(height: 30),
                            NonEditableRegisterItem(
                              title: 'CPF/CNPJ',
                              value: CpfCnpjAdapter.applyMask(user.document),
                            ),
                            const SizedBox(height: 30),
                            NonEditableRegisterItem(
                              title: 'E-mail',
                              value: user.email,
                            ),
                            const SizedBox(height: 30),
                            NonEditableRegisterItem(
                              title: 'Telefone',
                              value: PhoneAdapter.applyMask(user.phone),
                            ),
                            const SizedBox(height: 30),
                            RegisterItemField(
                              title: 'Senha',
                              controller: controller.passwordController,
                              hint: 'Insira sua senha',
                              isPassword: true,
                              validator: controller.passwordValidator,
                            ),
                            const SizedBox(height: 30),
                            RegisterItemField(
                              title: 'Confirmar senha',
                              controller: controller.repeatPasswordController,
                              hint: 'Insira novamente sua senha',
                              isPassword: true,
                              validator: controller.repeatPasswordValidator,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CooButton.primary(
                    label: 'Próximo',
                    onPressed: () => controller.register(user),
                  ),
                  SizedBox(height: keyboardHeight)
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
