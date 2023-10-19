import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              _ListaCategorias(),

              Expanded(
                child: ListaNoticias(newService.getArticulosCategoriaSeleccionada!)
              ),
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
    
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {

          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[index]),
                SizedBox(height: 5,),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final CategoryModel categoria;

  const _CategoryButton({
    super.key,
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // print('${categoria.name}');
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          categoria.icon,
          color: (newService.selectedCategory == this.categoria.name)
              ? Colors.red
              : Colors.black54
        ),
      ),
    );
  }
}