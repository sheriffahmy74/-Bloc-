import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/Data/models/quote.dart';
import 'package:flutter_breaking/Data/repositry/characters_repositry.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Charcters> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Charcters> getAllCharacters() {
    charactersRepository
        .getAllCharacters()
        .then((characters) {
          if (!isClosed) {
            emit(CharactersLoded(characters));
            this.characters = characters;
          }
        })
        .catchError((error) {
          if (!isClosed) {
            print('Error fetching characters: $error');
          }
        });

    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository
        .getCharacterQuotes(charName)
        .then((quotes) {
          if (!isClosed) {
            emit(QuotesLoded(quotes));
          }
        })
        .catchError((error) {
          if (!isClosed) {
            print('Error fetching quotes: $error');
          }
        });
  }
}
