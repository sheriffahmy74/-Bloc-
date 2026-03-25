import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/Data/repositry/characters_repositry.dart';
import 'package:flutter_breaking/Data/web_servics/characters_web_services.dart';
import 'package:flutter_breaking/Presentation/screens/characcters_screen.dart';
import 'package:flutter_breaking/Presentation/screens/characters_detalis_Screen.dart';
import 'package:flutter_breaking/constants/strings.dart';

class AppRouter {
  late CharactersRepository characterrepository;
  late CharactersCubit characterscubit;

  AppRouter() {
    characterrepository = CharactersRepository(CharactersWebService());
    characterscubit = CharactersCubit(characterrepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characctersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterscubit,
            child: CharacctersScreen(),
          ),
        );

      case characctersDetaliasScreen:
        final character = settings.arguments as Charcters;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => CharactersCubit(characterrepository),
                child: CharactersDetalis(character: character)
                 
                ),
        );

      default:
        return null;
    }
  }
}
