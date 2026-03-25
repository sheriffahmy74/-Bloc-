import 'package:flutter/material.dart';
import 'package:flutter_breaking/app_router.dart';

void main() {
  runApp(BreakingBadApp(approuter:AppRouter()));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key, required this.approuter});

  final AppRouter approuter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    onGenerateRoute:approuter.generateRoute
    
    
    );
    
  }
}
