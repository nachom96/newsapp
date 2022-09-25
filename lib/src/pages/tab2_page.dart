import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: _ListaCategorias()),
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {

        final cName = categories[index].name; // Para capitalizar el texto

        // Este SizedBox es simplemente para que haya un poquito de separación
        return SizedBox(
          width: 110,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[index]),
                const SizedBox(height: 5,),
                Text( '${ cName[0].toUpperCase() }${cName.substring(1)}'),
              ],
            ),
            ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton({required this.categoria});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ print('${categoria.name}');},
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,        
        ),
        child: Icon(
          categoria.icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}