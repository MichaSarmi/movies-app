

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/providers.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? titleSection;
  final Function onNextPage;
   
  const MovieSlider({
    Key? key, 
    required this.movies,
    this.titleSection, 
    required this.onNextPage
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollControler = ScrollController();

  @override
  void initState(){
    super.initState();
     //iniziliza,p el dispose luego codigo
     scrollControler.addListener(() {
        if(scrollControler.position.pixels >= (scrollControler.position.maxScrollExtent ) - 500 ){
          widget.onNextPage();
         /* scrollControler.animateTo(
          scrollControler.position.pixels+120,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);*/
        }
    
     });
  }

  @override
  void dispose() {


    //ejecutamos codigo leugo dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //porcetajes de pantalla
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final sizeScreen= MediaQuery.of(context).size;
    //propiyy app Bar
    final sizeAppBar = AppBar().preferredSize;
     return StreamBuilder(
      stream: moviesProvider.suggestionSteram,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        
        if(widget.movies.isEmpty){
        return SizedBox(
        width: double.infinity,
        height: (sizeScreen.height*0.6-sizeAppBar.height),
        child: const Center(child: CircularProgressIndicator()),
      );
    }else{
      
        //final  movies = snapshot.data!;
        /*scrollControler.animateTo(
          scrollControler.position.pixels+120,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);*/
         return  SizedBox(
        width: double.infinity,
        height: (sizeScreen.height*0.6)-sizeAppBar.height,
        child: Column(
          //alinar los objetos,CLOUM NO TOMA EN CONCIDERACION LA ALINEACION DE TEXTOS OJO
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              if(widget.titleSection !=null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.titleSection!,
                    style:( GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.black.withAlpha(125),
                                )
                          )
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  controller: scrollControler,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  //aqui se escribio como un return explisito
                  itemBuilder: (_,index)=>_MoivePoster(sizeScreenDesglosed: sizeScreen.width*0.3 - 16, moviePopular: widget.movies[index],),
                ),
              )
            
          
          ],
        ),
        
    );
    }
        
        
      }
    );
   
    
   
  }
}

class _MoivePoster extends StatelessWidget {
  final double sizeScreenDesglosed;
  final Movie moviePopular;
  const _MoivePoster({
    Key? key,
    required this.sizeScreenDesglosed,
    required this.moviePopular ,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    moviePopular.heroId = 'slider-${moviePopular.id}';
    return Container(
      width: sizeScreenDesglosed,
      //height: 120, ()no es necesario
       
      margin: const EdgeInsets.all(16),
      child: Column(
        children:  [
           GestureDetector(
             onTap: (() {
             Navigator.pushNamed(context, '/details', arguments: moviePopular);
          }),
            child: Hero(
              tag: moviePopular.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:  FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(moviePopular.getFullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                  
                  ),
              ),
            ),
          ),
            const SizedBox(height: 8,),
             Text(
              moviePopular.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            )

        ]
      ),
      
    );
  }
}