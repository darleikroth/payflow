import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

typedef void BoletoCallback(BoletoModel model);

class BoletoListWidget extends StatefulWidget {
  final BoletoCallback? onPress;
  final BoletoCallback? onLongPress;

  const BoletoListWidget({
    Key? key,
    this.onPress,
    this.onLongPress,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: controller.boletosNotifier,
        builder: (_, boletos, __) {
          return Column(
            children: boletos.map((model) {
              return BoletoTileWidget(
                data: model,
                onLongPress: () {
                  if (widget.onLongPress != null) {
                    widget.onLongPress!(model);
                  }
                },
                onPress: () {
                  if (widget.onPress != null) {
                    widget.onPress!(model);
                  }
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
