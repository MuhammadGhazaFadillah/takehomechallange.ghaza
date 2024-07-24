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
        title: const Text('Character Detail'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterDetailLoaded) {
            final character = state.character;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      character.image,
                      fit: BoxFit.cover,
                    ),
                  ),
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
            return const Center(
                child: Text('Failed to load character details'));
          }
          return Container();
        },
      ),
    );
  }
}