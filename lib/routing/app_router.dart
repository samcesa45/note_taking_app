import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/screens/home_screen.dart';
import 'package:note_taking_app/screens/note_edit_screen.dart';
import 'package:note_taking_app/screens/note_view_screen.dart';
import 'package:note_taking_app/screens/search_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String createNoteRoute = '/create';
  static const String viewNoteRoute = '/view';
  static const String searchRoute = '/search';
static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: createNoteRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const NoteEditScreen(),
      ),
      GoRoute(
        path: '$viewNoteRoute/:noteId',
        builder: (BuildContext context, GoRouterState state) {
          final noteId = state.pathParameters['noteId']!;
          return NoteViewScreen(noteId: noteId);
        },
      ),
      GoRoute(
        path: '$createNoteRoute/:noteId',
        builder: (BuildContext context, GoRouterState state) {
          final noteId = state.pathParameters['noteId']!;
          return NoteEditScreen(noteId: noteId);
        },
      ),
      GoRoute(
        path: searchRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const SearchScreen(),
      ),
    ],
  );
}