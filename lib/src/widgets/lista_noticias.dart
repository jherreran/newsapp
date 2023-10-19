import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (context, index) {
        print('${noticias.length}');
        return _Noticia(noticia: this.noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
    super.key,
    required this.noticia,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia, index: index,),

        _TarjetaTitulo(noticia: noticia,),

        _TarjetaImagen(noticia: noticia,),

        _TarjetaBody(noticia: noticia,),

        _TarjetaBotones(),

        SizedBox(height: 10,),

        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {

  const _TarjetaBotones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {

            },
            fillColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Icon(Icons.star_border),
          ),

          SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: () {

            },
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody({
    super.key,
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;

  const _TarjetaImagen({
    super.key,
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50)
        ),
        child: Container(
          child: (noticia.urlToImage != null)
            ? FadeInImage(
                placeholder: AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(noticia.urlToImage)
              )
            : Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar({
    super.key,
    required this.noticia,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text('${noticia.source.name}. ',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;

  const _TarjetaTitulo({
    super.key,
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 10),
      child: Text(noticia.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}