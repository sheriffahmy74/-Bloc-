import 'package:flutter/material.dart';
import 'package:flutter_breaking/Data/models/charcters.dart';
import 'package:flutter_breaking/constants/mycolors.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final Charcters charcters;
  const CharacterItem({super.key, required this.charcters});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.all(8),
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: Mycolors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            characctersDetaliasScreen,
            arguments: charcters,
          );
        },
        child: GridTile(
          child: Hero(
            tag: charcters.id,
            child: Container(
              color: const Color.fromARGB(255, 56, 63, 71),
              child: charcters.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      placeholder: 'Assets/images/Loading.gif',
                      image: charcters.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('Assets/images/replachold.png'),
            ),
          ),
          footer: Container(
            color: Colors.black54,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            alignment: Alignment.bottomCenter,
            child: Text(
              "${charcters.name} ",
              style: TextStyle(
                height: 1.3,
                color: Mycolors.myWhite,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
