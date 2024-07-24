import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/bloc/character_bloc.dart';

class Detail extends StatelessWidget {
  final int characterId;

  Detail({required this.characterId});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Character Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharacterDetailLoaded) {
            final character = state.character;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(character.image),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(character.name, style: TextStyle(fontSize: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Species: ${character.species}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gender: ${character.gender}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Origin: ${character.origin}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Location: ${character.location}'),
                  ),
                ],
              ),
            );
          } else if (state is CharacterError) {
            return Center(child: Text('Failed to load character details'));
          }
          return Container();
        },
      ),
    );
  }
}