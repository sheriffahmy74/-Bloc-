import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/Business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/constants/mycolors.dart';

class CharactersDetalis extends StatefulWidget {
  final Charcters character;

  const CharactersDetalis({super.key, required this.character});

  @override
  State<CharactersDetalis> createState() => _CharactersDetalisState();
}

class _CharactersDetalisState extends State<CharactersDetalis> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        BlocProvider.of<CharactersCubit>(
          context,
          listen: false,
        ).getQuotes(widget.character.name);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      backgroundColor: Mycolors.myGray,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.character.name,
          style: TextStyle(color: Mycolors.myWhite),
        ),
        background: Hero(
          tag: widget.character.id,
          child: Image.network(widget.character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: Mycolors.myYellow,
      thickness: 2,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Mycolors.myWhite,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(fontSize: 16, color: Mycolors.myWhite),
          ),
        ],
      ),
    );
  }

  Widget checkInfoAreLoaded(CharactersState state) {
    if (state is QuotesLoded) {
      return displayRandomQuoteEmptySpace(state);
    } else {
      return showPrograssIndigator();
    }
  }

  Widget displayRandomQuoteEmptySpace(QuotesLoded state) {
    var quotes = state.quotes;
    if (quotes.isNotEmpty) {
      int randomQuoteIndex = quotes.length > 1
          ? Random().nextInt(quotes.length)
          : 0;
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Mycolors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: Mycolors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            key: ValueKey(randomQuoteIndex),
            repeatForever: true,
            pause: Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              FlickerAnimatedText(
                quotes[randomQuoteIndex].quote,
                textStyle: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showPrograssIndigator() {
    return Center(child: CircularProgressIndicator(color: Mycolors.myYellow));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('name : ', widget.character.name),
                    buildDivider(255),

                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                        return checkInfoAreLoaded(state);
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
