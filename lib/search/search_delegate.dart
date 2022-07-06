import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';


class MovieSearchDelegate extends SearchDelegate{
  @override
  String? get searchFieldLabel => 'Buscar';
//el query es la palabra dl buscador
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
        onPressed: (){
          query='';
        },
        icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(
        onPressed: (){
          //la segundo opcion es lo que yo deseo retornar desde donde abri
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer(){
    return const Center(
        child:Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 100,)
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return  _emptyContainer();
      
    }
  //llamar al provvedor
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    //FGeture uilder es imposble cancelarlo
    moviesProvider.getSugestionByQuery(query);
    return StreamBuilder(
      stream: moviesProvider.suggestionSteram,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        
        if(!snapshot.hasData) return  const Center(child:  CircularProgressIndicator());
        print('aqui');
        final  movies = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_,int index)=> MovieItem(movies[index])
            ),
        );
        
      }
    );

  }
  
}

class MovieItem extends StatelessWidget {

  final Movie movie;

  const MovieItem(this.movie);
  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}'; 
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg') ,
          image: NetworkImage(movie.getFullPosterImg),
          width: 64,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, '/details',arguments: movie);
      },
    );
  }
}

