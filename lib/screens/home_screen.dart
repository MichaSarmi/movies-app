import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //busca los pprvoiders definidios en el multipovider dentro del arbol de widgets , de no ecnontrarloscre un provider
    //lsitente true redibuja
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    //print(moviesProvider.getOnDisplayMovies());
    //moviesProvider.getSugestionPopularMovies();
    return   Scaffold(
      appBar: AppBar(
        title:  Text(
          'Peliculas en cines',
          style:( GoogleFonts.poppins(
            fontWeight: FontWeight.bold
            )
          ) 
        ),
        actions: [
          IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: (){
            showSearch(
              context: context,
              delegate: MovieSearchDelegate()
              );
          })
        ],
      ),
      body: MediaQuery.removePadding (
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Center(
          child: SingleChildScrollView(
             child:Column(
              children:  [
                //mando parametros para poder usarlo en cualqueir ugar con cuakqueir listado
                CardSwiper(movies: moviesProvider.listRenderMovies,),
                MovieSlider(
                  movies: moviesProvider.listRenderPopular, 
                  titleSection: 'Popular',
                  //parametro funcion
                  onNextPage: ()=> moviesProvider.getSugestionPopularMovies(),),
              ]
            )
          ),
        ),
      )
    );
     
    
  }
}