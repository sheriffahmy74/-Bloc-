import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/Presentation/widgets/character_Item.dart';
import 'package:flutter_breaking/constants/mycolors.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacctersScreen extends StatefulWidget {
  const CharacctersScreen({super.key});

  @override
  State<CharacctersScreen> createState() => _CharacctersScreenState();
}

class _CharacctersScreenState extends State<CharacctersScreen> {
  late List<Charcters> allcharacters;
  late List<Charcters> searchedForCharacters = [];
  bool _isSearching = false;
  final _scearchTextController = TextEditingController();

  Widget _buildSearchedFiled() {
    return TextField(
      controller: _scearchTextController,
      cursorColor: Mycolors.myGray,
      decoration: InputDecoration(
        hintText: 'Find a Character .....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Mycolors.myGray, fontSize: 18),
      ),
      style: TextStyle(color: Mycolors.myGray, fontSize: 18),
      onChanged: (searchedCharacters) {
        addSearchedForItemToSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacters) {
    searchedForCharacters = allcharacters
        .where(
          (character) => character.name.toLowerCase().startsWith(
            searchedCharacters.toLowerCase(),
          ),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Mycolors.myGray),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: Icon(Icons.search, color: Mycolors.myGray),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    _scearchTextController.clear();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget BuildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoded) {
          allcharacters = state.characters;
          return buildListWidgets();
        } else {
          return showLoadingIndecator();
        }
      },
    );
  }

  Widget showLoadingIndecator() {
    return Center(child: CircularProgressIndicator(color: Mycolors.myYellow));
  }

  Widget buildListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Mycolors.myGray,
        child: Column(children: [buildCharacterList()]),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _scearchTextController.text.isEmpty
          ? allcharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          charcters: _scearchTextController.text.isEmpty
              ? allcharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text("Characters", style: TextStyle(color: Mycolors.myGray));
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Mycolors.myGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/images/off.png'),
            SizedBox(height: 20),
            Text(
              "Can't connect .. check internet",
              style: TextStyle(
                fontSize: 22,
                color: Mycolors.myYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolors.myYellow,
        leading: _isSearching
            ? BackButton(color: Mycolors.myGray)
            : Container(),
        title: _isSearching ? _buildSearchedFiled() : _buildAppBarTitle(),
        actions: _buildAppBarAction(),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );

              if (connected) {
                return BuildBlocWidget();
              } else {
                return _buildNoInternetWidget();
              }
            },
        child: Center(
          child: CircularProgressIndicator(color: Mycolors.myYellow),
        ),
      ),
    );
  }
}
