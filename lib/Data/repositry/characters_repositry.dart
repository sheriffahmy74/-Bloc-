import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/Data/models/quote.dart';
import 'package:flutter_breaking/Data/web_servics/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebService charactersWebService;

  CharactersRepository(this.charactersWebService);

  Future<List<Charcters>> getAllCharacters() async {
    final List<dynamic> characters = await charactersWebService
        .getAllCharacters();

    return characters
        .map(
          (character) => Charcters.fromjson(character as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebService.getCharacterQuotes(charName);

    return quotes
        .map((quote) => Quote.fromJson(quote as Map<String, dynamic>))
        .toList();
  }
}
