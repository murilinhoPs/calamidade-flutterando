import 'package:coopartilhar/app/(public)/ask_help/new_ask_help/new_ask_help_page.dart';
import 'package:coopartilhar/app/features/address/entities/address_entity.dart';
import 'package:coopartilhar/app/features/address/interactor/controllers/new_address_controller.dart';
import 'package:coopartilhar/app/features/address/interactor/states/address_location_states.dart';
import 'package:coopartilhar/app/features/address/interactor/states/address_states.dart';
import 'package:coopartilhar/injector.dart';
import 'package:coopartilhar/routes.dart';
import 'package:core_module/core_module.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class NewAddressPage extends StatefulWidget {
  final String title;
  const NewAddressPage({super.key, this.title = 'Cadastrar Endereço'});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final NewAddressController controller = injector.get<NewAddressController>();
  bool isRegister = false;
  String title = '';
  @override
  void initState() {
    if (Routefly.query.arguments != null) {
      isRegister = Routefly.query.arguments['isRegister'];
      title = Routefly.query.arguments['title'] ?? widget.title;
    }
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState(:final AddressEntity data) => {
          Alerts.showSuccess(
              context, 'Endereço "${data.addressName}" criado com sucesso!'),
          isRegister
              ? Routefly.navigate(
                  routePaths.bankAccount.newBankAccount,
                  arguments: {
                    'isRegister': true,
                  },
                )
              : Routefly.pop(context)
        },
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.message),
      AddressLocationErrorState() => {
          Alerts.showFailure(context, 'Falha ao recuperar localização')
        },
      _ => null,
    };
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
            onPressed: Navigator.of(context).pop),
        surfaceTintColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, _) {
            return Stack(alignment: Alignment.bottomCenter, children: [
              const Image(image: CooImages.cooBackgroundDetails),
              SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextInformationExtends(
                                text: 'Identificação do Endereço'),
                            TextFormField(
                              controller: controller.identificationController,
                              decoration: InputDecoration(
                                hintText: 'Insira a Identificação do Endereço',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Identificação do Endereço não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'Logradouro'),
                            TextFormField(
                              controller: controller.addressController,
                              decoration: InputDecoration(
                                hintText: 'Insira o logradouro',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Logradouro não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'Número'),
                            TextFormField(
                              controller: controller.addressNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Insira o número',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Número não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'Cidade'),
                            TextFormField(
                              controller: controller.cityController,
                              decoration: InputDecoration(
                                hintText: 'Insira a cidade',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cidade não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'UF'),
                            TextFormField(
                              controller: controller.ufController,
                              maxLength: 2,
                              decoration: InputDecoration(
                                hintText: 'Insira a UF',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'UF não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'CEP'),
                            TextFormField(
                              controller: controller.zipCodeController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [ZipCodeInputFormatter()],
                              decoration: InputDecoration(
                                hintText: 'Informe o CEP',
                                hintStyle: hintStyle,
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'CEP não pode estar vazio';
                                }
                                return null;
                              },
                            ),
                            const TextInformationExtends(text: 'Complemento'),
                            TextFormField(
                              controller: controller.complementController,
                              decoration: InputDecoration(
                                hintText: 'Insira o complemento se houver',
                                hintStyle: hintStyle,
                              ),
                            ),
                            const TextInformationExtends(
                                text: 'Localização(geo/endereço)'),
                            CooInputButton(
                              controller: controller.geoLocationController,
                              isLoading: state is AddressLocationLoadingState,
                              iconData: UIcons.solidRounded.location_alt,
                              onTap: () async {
                                controller.geoLocation();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SafeArea(
                        child: CooButton.primary(
                          label: (state is LoadingState)
                              ? 'Aguarde...'
                              : 'Próximo',
                          onPressed: () => isRegister
                              ? Routefly.push(
                                  routePaths.bankAccount.newBankAccount,
                                  arguments: {
                                    'isRegister': true,
                                  },
                                )
                              : Routefly.pop(context),
                          size: const Size(double.infinity, 60),
                          enable: state is! AddressLoadingState &&
                              state is! LoadingState,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ]);
          }),
    );
  }
}
