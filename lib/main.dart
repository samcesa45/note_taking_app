import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/theme_controller.dart';
import 'package:note_taking_app/routing/app_router.dart';
import 'package:note_taking_app/services/local_storage_service.dart';
import 'package:note_taking_app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = SharedPreferencesLocalStorageService();
  await localStorageService.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeModeState = ref.watch(themeControllerProvider);
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Note Taking App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeState,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
