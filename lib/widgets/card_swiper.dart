
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/models.dart';


class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);
 
  
  @override
  Widget build(BuildContext context) {
    //porcetajes de pantalla
    final size= MediaQuery.of(context).size;
    //propiyy app Bar
    final sizeAppBar = AppBar().preferredSize;
    //aqui no renderizamos las peliculas
    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: (size.height*0.5-sizeAppBar.height),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return  SizedBox(
      width: double.infinity,
      height: (size.height*0.5-sizeAppBar.height),
      // el swiper de //https://pub.dev/packages/card_swiper
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.6,
        itemHeight: (size.height*0.4)-sizeAppBar.height,
        itemBuilder: (_,int index){
          //final movie = movies[index];
          //print(movie.fullPosterImg);
          movies[index].heroId = 'swiper-${movies[index].id}'; 
          return GestureDetector (
            onTap: (() {
               Navigator.pushNamed(context, '/details', arguments: movies[index]);
            }),
            child: Hero(
              tag:  movies[index].heroId!, //valor unico
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:  FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movies[index].getFullPosterImg),
                  //adaptar al padre 
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        },
      )
    
    );
  }
}