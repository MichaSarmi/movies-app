import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({
    Key? key,
    required this.movieId
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
 //llamo al proovedor de la info de back
    final moviesProvider =  Provider.of<MoviesProvider>(context, listen: true);
    return FutureBuilder(
      //instancio el provider
      future: moviesProvider.getMovieCasting(movieId),
      //initialData: InitalData,
      builder: (_, AsyncSnapshot<List<Cast>> snapshot){
        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
            margin: const EdgeInsets.only(top: 120),
            width: double.infinity,
            height: 250,
            child: const CircularProgressIndicator(),
          );
        }
        //la lista de cast q viene del snapshot
        
        final List<Cast> cast = snapshot.data!;
         return  Container(
         margin: const EdgeInsets.only(bottom: 32),
         width: double.infinity,
         height: 250,
         child:  ListView.builder(
         itemCount: cast.length,
         scrollDirection: Axis.horizontal,
         itemBuilder: (_, int index){
          return  _CastCard(actor: cast[index],);
        }),
      
    );
      });
    
   
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
const _CastCard({
  Key? key,
  required this.actor
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size; 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(

        width: size.width/4 - 24,
        height: 180,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image:  NetworkImage(actor.getFullprofilePath),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
              Text(
                actor.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Colors.black.withAlpha(125),
                    ),
              )
          ]),
      ),
    );
  }
}