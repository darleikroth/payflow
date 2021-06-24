import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';

class DividerHorizontalWidget extends StatelessWidget {
  const DividerHorizontalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.stroke,
    );
  }
}
