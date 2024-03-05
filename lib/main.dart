import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/components/categories_page.dart';
import 'package:meal_app/components/meal_page.dart';
import 'package:meal_app/core/category.dart';
import 'package:meal_app/core/meal.dart';
import 'package:meal_app/core/data_service.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 146, 86, 195),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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

  ListView _groupedListView(List<Meal> meals, List<Category> categories) {
    return ListView.builder(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                category.title,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 169, 64, 255)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryMeals.length,
              itemBuilder: (context, mealIndex) {
                final meal = categoryMeals[mealIndex];
                return ListTile(
                  title: Text(
                    meal.title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  subtitle: Text(
                    '${meal.complexity.toString().split('.').last} | ${meal.affordability.toString().split('.').last} | ${meal.duration.toString()} min',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MealPage(meal: meal)),
                    );
                  },
                );
              },
            ),
            const Divider(),
          ],
        );
      },
    );
  }

  GridView _categoriesGridView(List<Category> categories) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // You can adjust the cross axis count as needed
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5, // You can adjust the aspect ratio as needed
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryPage(
                        category: category,
                        dataService: dataService,
                      )),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).cardColor,
            child: Center(
              child: Text(
                category.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = dataService.getCategories();
    List<Meal> meals = dataService.getMeals();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories & Meals'),
        ),
        body: _categoriesGridView(categories));
  }
}
