import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  const ListaNoticias({
    Key? key, 
    required this.noticias
    }) : super(key: key);
  
  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      }, 
    );
  }
}

class _Noticia extends StatelessWidget {
  
  final Article noticia;
  final int index;
  
  const _Noticia({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia, index: index,),
        _TarjetaTitulo( noticia: noticia ),
        _TarjetaImagen ( noticia: noticia),
        _TarjetaBody ( noticia: noticia ),
        _TarjetaBotones(),
        const SizedBox(height: 10,),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.colorScheme.secondary,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
            ),

          const SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
            ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody({
    required this.noticia
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Text( (noticia.description != null ) ? noticia.description.toString() : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen({
    required this.noticia
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: ( noticia.urlToImage != null) 
          ? FadeInImage(
            placeholder: const AssetImage('assets/img/giphy.gif'), 
            image: NetworkImage( noticia.urlToImage.toString()),
            )
          : const Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {  
  
  final Article noticia;

  const _TarjetaTitulo({
    required this.noticia
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 15),
      child: Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar({
    required this.noticia,
    required this.index
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: miTema.colorScheme.secondary),),
          Text('${noticia.source.name }. '),
        ],
      ),
    );
  }
}