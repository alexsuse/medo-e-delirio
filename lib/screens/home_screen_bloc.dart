import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medo_e_delirio_app/screens/home/home_bloc.dart';
import 'package:medo_e_delirio_app/screens/search_modal.dart';
import 'package:medo_e_delirio_app/widgets/default_error_message.dart';
import 'package:medo_e_delirio_app/widgets/default_progress_indicator.dart';
import 'package:medo_e_delirio_app/widgets/media_panel.dart';
import 'package:provider/provider.dart';

import '../color_palette.dart';
import '../models/audio.dart';
import 'home/home_model.dart';

class HomeScreenBloc extends StatefulWidget {
  final HomeBloc bloc;

  HomeScreenBloc({required this.bloc});

  static Widget create(BuildContext context, List<Audio> audios) {
    return Provider<HomeBloc>(
      create: (_) => HomeBloc(audios: audios),
      child: Consumer<HomeBloc>(
        builder: (_, bloc, __) => HomeScreenBloc(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  State<HomeScreenBloc> createState() => _HomeScreenBlocState();
}

class _HomeScreenBlocState extends State<HomeScreenBloc> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    ScrollController _scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0XFF243119),
              pinned: false,
              expandedHeight: _screenSize.height * .25,
              toolbarHeight: _screenSize.height * .1,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/med_full_logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(
                      top: _screenSize.height * .004,
                      right: _screenSize.width * 0.05),
                  decoration: BoxDecoration(
                      color: ColorPalette.primary, shape: BoxShape.circle),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchModal(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      icon: Icon(FontAwesomeIcons.question,
                          color: ColorPalette.tertiary,
                          size: _screenSize.height * .042),
                      highlightColor: ColorPalette.primary,
                    ),
                  ),
                )
              ],
              automaticallyImplyLeading: true,
            ),
            SliverToBoxAdapter(
              child: StreamBuilder(
                stream: widget.bloc.modelStream,
                initialData: HomeModel(audios: widget.bloc.audios),
                builder:
                    (BuildContext context, AsyncSnapshot<HomeModel> snapshot) {
                  if (snapshot.hasError) {
                    return DefaultErrorMessage(action: () {
                      //this._search([]);
                      this.setState(() {});
                    });
                  }

                  if (!snapshot.hasData) {
                    return DefaultProgressIndicator(
                        message: 'Calma, fdp. Calma!');
                  }

                  if (snapshot.data!.isLoading) {
                    return DefaultProgressIndicator(
                        message: 'Calma, fdp. Calma!');
                  }

                  List<Audio> audios = snapshot.data!.audios;

                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(_screenSize.width * 0.02),
                        child: TextField(
                          style: TextStyle(
                              color: ColorPalette.secondary,
                              fontSize: _screenSize.width * 0.04),
                          controller: this.searchController,
                          onChanged: (value) {
                            if (value.length > 3) {
                              widget.bloc.search(value);
                            }

                            if (value.length == 0) {
                              widget.bloc.refreshAudios();
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: ColorPalette.secondary,
                                fontSize: _screenSize.width * .04),
                            hintStyle: TextStyle(color: ColorPalette.secondary),
                            hintText: 'autor ou descrição',
                            labelText: 'digite sua pesquisa',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPalette.secondary)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPalette.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPalette.secondary)),
                          ),
                        ),
                      ),
                      GridView.count(
                        controller: _scrollController,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: audios.map((Audio audio) {
                          return MediaPanel(_screenSize, audio);
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverAppBar(
              pinned: false,
              backgroundColor: Color(0XFF243119),
              expandedHeight: _screenSize.height * .05,
              centerTitle: true,
              title: Text(
                'criado por @sidroniolima',
                style: TextStyle(
                    fontSize: _screenSize.width * .032,
                    color: ColorPalette.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
