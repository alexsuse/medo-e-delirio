import 'package:flutter/material.dart';
import 'package:medo_e_delirio_app/screens/home_screen_bloc.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomeScreenBloc.create(context),
    );
  }
}
