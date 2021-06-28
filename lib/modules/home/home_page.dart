import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final pages = [
    Container(color: Colors.cyan),
    Container(color: Colors.deepPurpleAccent),
  ];
  final iconHomeColor = [
    AppColors.primary,
    AppColors.body,
  ];
  final iconDocumentColor = [
    AppColors.body,
    AppColors.primary,
  ];

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController();

    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sair'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Deseja realmente sair da sua conta?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('SAIR'),
                onPressed: () {
                  Navigator.of(context).pop();
                  loginController.googleSignOut(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: _Header(
          showDialog: _showDialog,
        ),
      ),
      body: pages[controller.currentPage],
      bottomNavigationBar: _BottomNavigationBar(
        documentTintColor: iconDocumentColor[controller.currentPage],
        homeTintColor: iconHomeColor[controller.currentPage],
        onTapHome: () {
          controller.setPage(0);
          setState(() {});
        },
        onTapDocument: () {
          controller.setPage(1);
          setState(() {});
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback showDialog;

  const _Header({Key? key, required this.showDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthController>();

    return Container(
      height: 152,
      color: AppColors.primary,
      child: Center(
        child: ListTile(
          title: Text.rich(TextSpan(
              text: "Olá, ",
              style: TextStyles.titleRegular,
              children: [
                TextSpan(
                  text: auth.user?.nickname ?? "",
                  style: TextStyles.titleBoldBackground,
                ),
              ])),
          subtitle: Text(
            "Mantenha suas contas em dia",
            style: TextStyles.captionShape,
          ),
          trailing: InkWell(
            onTap: showDialog,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                image: auth.user?.photoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(auth.user!.photoUrl!),
                        fit: BoxFit.fill)
                    : null,
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapDocument;
  final Color homeTintColor;
  final Color documentTintColor;

  const _BottomNavigationBar({
    Key? key,
    required this.onTapHome,
    required this.onTapDocument,
    required this.homeTintColor,
    required this.documentTintColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onTapHome,
            icon: Icon(Icons.home_outlined),
            color: homeTintColor,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, "/barcode_scanner");
              Navigator.pushNamed(context, "/insert_boleto");
            },
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.add_box_outlined),
            ),
          ),
          IconButton(
            onPressed: onTapDocument,
            icon: Icon(Icons.description_outlined),
            color: documentTintColor,
          ),
        ],
      ),
    );
  }
}
