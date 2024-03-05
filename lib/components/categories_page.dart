import 'package:flutter/material.dart';
import 'package:meal_app/components/meal_page.dart';
import 'package:meal_app/core/category.dart';
import 'package:meal_app/core/meal.dart';
import 'package:meal_app/core/data_service.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  final DataService dataService;

  CategoryPage({required this.category, required this.dataService});

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = dataService.getMealsByCategory(category.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return ListTile(
            title: Text(meal.title),
            subtitle: Text(
              '${meal.complexity.toString().split('.').last} | ${meal.affordability.toString().split('.').last} | ${meal.duration.toString()} min',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MealPage(meal: meal)),
              );
            },
          );
        },
      ),
    );
  }
}
