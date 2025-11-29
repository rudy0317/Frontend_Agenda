import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'agenda_list.dart';

void main() {
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.orbitronTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFF00FF),
      secondary: Color(0xFF00E5FF),
      surface: Color(0xFF0B0018),
      surfaceContainerHighest: Color(0xFF050010), // pengganti background
      ),

    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda Cyberpunk',
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: const Color(0xFF050010),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF00FF),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0x800B0018),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF00E5FF),
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0x40FFFFFF),
              width: 0.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFFF00FF),
              width: 1.5,
            ),
          ),
          labelStyle: const TextStyle(color: Color(0xFF9E9EFD)),
        ),

        cardTheme: const CardThemeData(
          color: Color(0x990B0018),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF00FF),
          foregroundColor: Colors.black,
        ),
      ),
      home: const AgendaListPage(),
    );
  }
}
