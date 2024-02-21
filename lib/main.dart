import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/core/category.dart';
import 'package:meal_app/core/meal.dart';
import 'package:meal_app/core/data_service.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: CategoryMealWidget());
  }
}

class CategoryMealWidget extends StatefulWidget {
  @override
  _CategoryMealWidgetState createState() => _CategoryMealWidgetState();
}

class _CategoryMealWidgetState extends State<CategoryMealWidget> {
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    List<Category> categories = dataService.getCategories();
    List<Meal> meals = dataService.getMeals();
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories & Meals'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryMeals = meals
              .where((meal) => meal.categories.contains(category.id))
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  category.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryMeals.length,
                itemBuilder: (context, mealIndex) {
                  final meal = categoryMeals[mealIndex];
                  return ListTile(
                    title: Text(meal.title),
                  );
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
