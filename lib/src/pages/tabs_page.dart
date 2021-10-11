// ignore_for_file: unnecessary_new, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_this

import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        // ignore: prefer_const_constructors
        body: _Pages(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    // Para cargar los headlines si no aparecieran, se llama al servicio
    //final newsService = Provider.of<NewsService>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Categorías')
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionmodel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionmodel.pageController,
      // ignore: prefer_const_constructors
      // physics: BouncingScrollPhysics(),
      // ignore: prefer_const_constructors
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    // Notificar un procedimiento
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
