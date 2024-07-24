import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/bloc/character_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/pages/detail.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            return ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name),
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<CharacterBloc>()..add(GetCharacterDetailEvent(id: character.id)),
                          child: Detail(characterId: character.id),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No Favorite available'));
          }
        },
      ),
    );
  }
}