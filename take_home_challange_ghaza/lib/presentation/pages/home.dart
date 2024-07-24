import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/bloc/character_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/pages/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _loadCharacters() async {
    context.read<CharacterBloc>().add(GetCharactersEvent());
  }

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadCharacters,
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharacterLoaded) {
              return ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final character = state.characters[index];
                  return ListTile(
                    leading: Image.network(character.image),
                    title: Text(character.name),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: context.read<CharacterBloc>()
                              ..add(GetCharacterDetailEvent(id: character.id)),
                            child: Detail(characterId: character.id),
                          ),
                        ),
                      );
                      _loadCharacters();
                    },
                  );
                },
              );
            } else if (state is CharacterError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}