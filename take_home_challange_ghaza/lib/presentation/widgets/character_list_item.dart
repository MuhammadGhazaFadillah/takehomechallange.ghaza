import 'package:flutter/material.dart';
import 'package:take_home_challange_ghaza/domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  CharacterListItem({required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(character.image),
      title: Text(character.name),
      subtitle: Text(character.species),
      onTap: () {
        // Navigate to detail page
      },
    );
  }
}