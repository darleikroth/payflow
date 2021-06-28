import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatelessWidget {
  const InsertBoletoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          brightness: Brightness.dark,
          elevation: 0,
          leading: BackButton(
            color: AppColors.input,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
                child: Text(
                  "Preencha dos dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              InputTextWidget(
                label: "Nome do boleto",
                icon: Icons.description_outlined,
                onChanged: (value) {
                  //
                },
              ),
              InputTextWidget(
                label: "Vencimento",
                icon: FontAwesomeIcons.timesCircle,
                onChanged: (value) {
                  //
                },
              ),
              InputTextWidget(
                label: "Valor",
                icon: FontAwesomeIcons.wallet,
                onChanged: (value) {
                  //
                },
              ),
              InputTextWidget(
                label: "Código",
                icon: FontAwesomeIcons.barcode,
                onChanged: (value) {
                  //
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: SetLabelButtons(
          primaryLabel: "Cancelar",
          onPrimaryPressed: () {
            Navigator.pop(context);
          },
          secondaryLabel: "Cadastrar",
          onSecondaryPressed: () {},
          enableSecondaryColor: true,
        ),
      ),
      onFocusLost: () {
        // on blur
      },
      onFocusGained: () {
        // on focus
      },
    );
  }
}
