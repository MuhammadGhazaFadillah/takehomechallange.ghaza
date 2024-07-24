import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challange_ghaza/data/local/db_helper.dart';
import 'package:take_home_challange_ghaza/data/repositories/charcter_repo_impl.dart';
import 'package:take_home_challange_ghaza/presentation/bloc/character_bloc.dart';
import 'package:take_home_challange_ghaza/presentation/pages/home.dart';
import 'package:take_home_challange_ghaza/presentation/pages/search.dart';
import 'package:take_home_challange_ghaza/presentation/pages/favorite.dart';
import 'package:http/http.dart' as http;
import 'package:take_home_challange_ghaza/data/datasources/character_remote_datasource.dart';
import 'package:take_home_challange_ghaza/domain/usecases/add_favorite.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_all_characters.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_character_detail.dart';
import 'package:take_home_challange_ghaza/domain/usecases/get_favorites.dart';
import 'package:take_home_challange_ghaza/domain/usecases/remove_favorite.dart';
import 'package:take_home_challange_ghaza/domain/usecases/search_characters.dart';
void main() {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  runApp(MyApp(databaseHelper: databaseHelper));
}

class MyApp extends StatelessWidget {
  final DatabaseHelper databaseHelper;
  MyApp({required this.databaseHelper});

  @override
  Widget build(BuildContext context) {
    final characterRemoteDatasource = CharacterRemoteDatasource(client: http.Client());

    final characterRepository = CharacterRepositoryImpl(remoteDatasource: characterRemoteDatasource);

    final getAllCharacters = GetAllCharacters(characterRepository);
    final getCharacterDetail = GetCharacterDetail(characterRepository);
    final searchCharacters = SearchCharacters(characterRepository);
    final addFavorite = AddFavorite(characterRepository);
    final removeFavorite = RemoveFavorite(characterRepository);
    final getFavorites = GetFavorites(characterRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharacterBloc(
            getAllCharacters: getAllCharacters,
            getCharacterDetail: getCharacterDetail,
            searchCharacters: searchCharacters,
            addFavorite: addFavorite,
            removeFavorite: removeFavorite,
            getFavorites: getFavorites,
            databaseHelper: databaseHelper,

          )..add(GetCharactersEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Home(),
    Search(),
    Favorite(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}