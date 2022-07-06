
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/themes/app_theme.dart';
import 'package:movies/widgets/casting_cards.dart';

import '../models/models.dart';


class DetailsScreen extends StatelessWidget {
  
  
  const DetailsScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
   final size= MediaQuery.of(context).size;
   final sizeAppBar = AppBar().preferredSize;
     //recibir variables trnaformando y asegurandose q es tipo pelicuola si no da error
   final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
   print(movie);
    return    Scaffold(
      //sierve para trabajar co slovers
      body:  CustomScrollView(
        //scrollDirection: Axis.vertical,
        //physics:const BouncingScrollPhysics(), NO FUINCIONA EN ANDROID
        
        slivers: [
         
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate([
              
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: size.height - sizeAppBar.height
                ),
                //color: Colors.red,
                child: Column(
                  children: [
                    Container(height: 24),
                    _PosterAndTitle(movie: movie),
                    _Overview(movie: movie),
                    CastingCards(movieId: movie.id,)
                  ],
                ),
              )
            ])
            )

        ],// widgests con comportamiento programado al ahcer scroll
      )
    );
  }
}
class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({
    required this.movie
    });
  //const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SliverAppBar( // se controla ancho y alto
      backgroundColor:  AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title:  Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 16 ,left: 8, right: 8),
          child: Text(
            movie.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.white,
               shadows: <Shadow>[
                const Shadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ]
            ),
            )
          ),
        background:  FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getBackdropPath),
          fit: BoxFit.cover,
          ),
        
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
   final Movie movie;

  const _PosterAndTitle({
     required this.movie
  });
  @override
  Widget build(BuildContext context) {
     final size= MediaQuery.of(context).size;
    return Container(
      //height: size.height +200,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.getFullPosterImg),
                height:200 ,
              ),
            ),
          ),
          const SizedBox(width: 16,),
          SizedBox(
             width: size.width - 136- 32 -32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black.withAlpha(125),
                    ),
                  ),
                  Text(
                  movie.originalTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black.withAlpha(125),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_outline,
                        size: 24,
                        color: Colors.grey,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          movie.popularity.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.black.withAlpha(125),
                            ),
                        ),
                  
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {
 
 final Movie movie;

  const _Overview({
     required this.movie
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: Colors.black.withAlpha(125),
                  ),
      ),
    );
  }
}

