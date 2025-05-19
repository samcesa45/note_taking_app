import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:note_taking_app/constants/colors.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/controllers/theme_controller.dart';
import 'package:note_taking_app/routing/app_router.dart';
import 'package:note_taking_app/widgets/category_chips_row.dart';
import 'package:note_taking_app/widgets/date_picker_row.dart';
import 'package:note_taking_app/widgets/header.dart';
import 'package:note_taking_app/widgets/notes_grid.dart';
import 'package:note_taking_app/widgets/search_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;

  final List<Color> noteColors = [
    AppColors.appBlue1,
    AppColors.appPink1,
    AppColors.appYellow1,
    AppColors.appYellow2,
    AppColors.appGreen,
    AppColors.appPink2,
    AppColors.appBlue2,
    AppColors.appPink3,
  ];

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category == 'All' ? null : category;
    });
  }

  void _showSettingsSheet(BuildContext context) {
    final currentThemeMode = ref.watch(themeControllerProvider);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_4_outlined),
              title: const Text('Select Theme'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Theme'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<ThemeMode>(
                            title: const Text('System'),
                            value: ThemeMode.system,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Light'),
                            value: ThemeMode.light,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Dark'),
                            value: ThemeMode.dark,
                            groupValue: currentThemeMode,
                            onChanged: (ThemeMode? value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setThemeMode(value!);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final notes = ref.watch(notesProvider);
    final notes = ref.watch(sortedNotesProvider);
    final formattedMonthYear = DateFormat('yyyy MMMM').format(_selectedDate);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      formattedMonthYear,
                      () => _showSettingsSheet(context),
                    ),
                    const SizedBox(height: 20),
                    const SearchAndFilterBar(),
                    const SizedBox(height: 20),
                    DatePickerRow(
                      selectedDate: _selectedDate,
                      onDateSelected: _selectDate,
                    ),
                    const SizedBox(height: 20),
                   CategoryChipsRow(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _selectCategory,
                   )
                  ],
                ),
              ),
            ),
          ),
          notes.isEmpty
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: const Text('No notes yet. Tap the + to add one!'),
                ),
              )
              : NotesGrid(notes: notes)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRouter.createNoteRoute),
        child: const Icon(Icons.add, size: 32.0),
      ),
    );
  }
}
