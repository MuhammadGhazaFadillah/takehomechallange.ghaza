import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/bloc/character_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/pages/detail.dart';

class Search extends StatefulWidget{
  @override   
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Characters'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              final query = _searchController.text;
              if (query.isNotEmpty) {
                context.read<CharacterBloc>().add(SearchCharactersEvent(query: query));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Find the Character',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<CharacterBloc>().add(SearchCharactersEvent(query: query));
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
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
                        subtitle: Text(character.species),
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
                  return Center(child: Text('Failed to load the results'));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}