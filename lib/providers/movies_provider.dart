
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/serch_response.dart';

import '../helper/debouncer.dart';
import '../models/models.dart';


class MoviesProvider extends ChangeNotifier{

  final String _BaseURL='api.themoviedb.org';
  final String _jwt = '403e1e3d6219cf82ae89f152a02bcc3d';
  final String _language = 'es-ES';

  List<Movie> listRenderMovies = [];
  List<Movie> listRenderPopular =[];
  Map<int,List<Cast>> listMoviesCast ={};

  int _popularPage=0;
  //control del debouncer
  //bordcast es para quitar todas las subcripciones
  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  //este streem va a estar siempre escuchando
  Stream<List<Movie>> get  suggestionSteram => _suggestionStreamController.stream;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 400),
  );

  MoviesProvider(){
    getOnDisplayMovies();
    getSugestionPopularMovies();
  }

// metodogenerico para get
//[int page = 1] es opcional con valor predeterminado 1
  Future<String> _getJsonData(String endPoint, int page) async{
    final url =Uri.https(_BaseURL, endPoint, {
          'api_key': _jwt,
          'language':_language ,//obtener el lenguaje de ua variable global
          'page':'$page'
    });

      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      return response.body;
  }

  getOnDisplayMovies()  async {
  final jsonData = await _getJsonData('/3/movie/now_playing',1);
  final responsePlaying = NowPlayingResponse.fromJson(jsonData);
  //damos a la lista del backend a lo que se va a renderizar
  listRenderMovies= responsePlaying.results;
  //notifica a los widggets que se deben redibujar po que hay cambio en la data
  notifyListeners();
  }

  getPopularMovies() async{
  _popularPage++;
  print(_popularPage);
//AQUI LA APLICACION PEUDE UQEDARSE PEGADA POR Q NO HAY UN CONTROLL EN EL SCROLL

 //print(_popularPage);
  final jsonData = await _getJsonData('/3/movie/popular',_popularPage);
  final responsePopular = PopularResponse.fromJson(jsonData);

  //damos a la lista del backend a lo que se va a renderizar
  //[concatena la lsita a la nueva peticion cuando detecte un cambio]
  listRenderPopular= [...listRenderPopular, ...responsePopular.results];
  //notifica a los widggets que se deben redibujar po que hay cambio en la data
  notifyListeners(); //no se necesita el notify listener por q se esta jhaciendo con el debonce
  return listRenderPopular;

  

  }

  Future<List<Cast>> getMovieCasting(int movieId) async{
    //asi nos aseguramos de no hacer la peticion al back si ya lo tengo en memoria
    if(listMoviesCast.containsKey(movieId)) return listMoviesCast[movieId]!;
    //print('pidiendo actores al back');
    final jsonData = await _getJsonData('/3/movie/$movieId/credits',1);
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    listMoviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> serchMovies(String query) async{
    final url =Uri.https(_BaseURL, '3/search/movie', {
          'api_key': _jwt,
          'language':_language ,//obtener el lenguaje de ua variable global
          'query': query
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body); 

    return searchResponse.results;
  }

  //metodo mete el query al stream, cuando el bouncer emita el valor
  //controlar las paticiones al back con un debouncer personalizado
  void getSugestionByQuery(String searchTerm){
    debouncer.value = '';
    debouncer.onValue=(value) async{
      //se peude usar el searchTeam p[ero el value se usa por q es cuando se termina de escribir]
      final result = await serchMovies(value); 
      _suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) { 
      debouncer.value = searchTerm;
    });
    //canclear la peticion
    Future.delayed(const Duration(milliseconds: 301)).then(
      (value) => timer.cancel()
      ).catchError((error){
        print('error search $error');
      });
  }

  //debonce del peticions de peliculas

  void getSugestionPopularMovies(){
    debouncer.value = '';
    debouncer.onValue=(value) async{
      //se peude usar el searchTeam p[ero el value se usa por q es cuando se termina de escribir]
      final result = await getPopularMovies(); 
      _suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 100), (_) { 
      debouncer.value = _popularPage;
    });
    //canclear la peticion
    Future.delayed(const Duration(milliseconds: 101)).then(
      (value) => timer.cancel()
      ).catchError((error){
        print('error search $error');
      });
  }

  
  
}