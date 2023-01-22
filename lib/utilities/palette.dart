import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor kToDark = const MaterialColor( 
    0xff7889B5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xff7889B5 ),//10% 
      100: const Color(0xff7889B5),//20% 
      200: const Color(0xff7889B5),//30% 
      300: const Color(0xff7889B5),//40% 
      400: const Color(0xff7889B5),//50% 
      500: const Color(0xff7889B5),//60% 
      600: const Color(0xff7889B5),//70% 
      700: const Color(0xff7889B5),//80% 
      800: const Color(0xff7889B5),//90% 
      900: const Color(0xff7889B5),//100% 
    }, 
  ); 
}