part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoded extends CharactersState {
  final List<Charcters> characters;

  CharactersLoded(this.characters);
}

class QuotesLoded extends CharactersState {
  final List<Quote> quotes;

  QuotesLoded(this.quotes);
}
