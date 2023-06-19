import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medo_e_delirio_app/color_palette.dart';

class SearchModal extends StatefulWidget {
  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  List<String> selectedList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: _screenSize.height,
          padding: EdgeInsets.symmetric(
              vertical: _screenSize.height * 0.03,
              horizontal: _screenSize.width * 0.03),
          decoration: BoxDecoration(
            color: Color(0XFF243119),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Em breve, aqui ficarão seus áudios favoritos.\n\nAproveite, se puder, e pague uma cerveja ao desenvolvedor por PIX. É só copiar a chave abaixo mantendo o dedo em cima dela.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      wordSpacing: 1.2,
                      fontSize: _screenSize.height * 0.018,
                      color: ColorPalette.secondary,
                    ),
                  ),
                  SizedBox(
                    height: _screenSize.height * 0.050,
                  ),
                  SelectableText(
                    '77d6aecd-f99f-45a3-8852-9d9b91de1f9d',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: _screenSize.height * 0.020,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _screenSize.height * 0.040,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.question,
                    color: ColorPalette.tertiary,
                    size: _screenSize.height * 0.05,
                  ),
                  Flexible(
                    child: Text(
                      'Toque no Card para ouvir e mantenha pressionado para compartilhar.',
                      style: TextStyle(
                          fontSize: _screenSize.height * 0.02,
                          color: ColorPalette.tertiary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
