import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
       ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Para ti'),
      BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
    ],);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final navegacionMoel = Provider.of<_NavegacionModel>(context);

    
    return PageView(
      controller: navegacionMoel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.red,            
        ),
        Container(
          color: Colors.green,            
        ),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = PageController(initialPage: 0);
  
  int get paginaActual => _paginaActual;

  set paginaActual( int valor ){
    _paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    
    notifyListeners();
  }

  PageController get pageController => _pageController;


}