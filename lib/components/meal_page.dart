import 'package:flutter/material.dart';
import 'package:meal_app/components/attributes.dart';
import 'package:meal_app/core/meal.dart';

class MealPage extends StatelessWidget {
  final Meal meal;

  const MealPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Stack(
        children: [
          Image.network(
            meal.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard('Ingredients', [
                      for (var ingredient in meal.ingredients)
                        Text('• $ingredient',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                    ]),
                    SizedBox(height: 16),
                    _buildCard('Steps', [
                      for (int i = 0; i < meal.steps.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${i + 1}. ${meal.steps[i]}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            SizedBox(height: 8),
                          ],
                        ),
                    ]),
                    SizedBox(height: 16),
                    _buildCard('Properties', [
                      SizedBox(height: 16),
                      BooleanAttribute(
                        label: 'Gluten Free',
                        value: meal.isGlutenFree,
                      ),
                      SizedBox(height: 8),
                      BooleanAttribute(
                        label: 'Lactose Free',
                        value: meal.isLactoseFree,
                      ),
                      SizedBox(height: 8),
                      BooleanAttribute(
                        label: 'Vegan',
                        value: meal.isVegan,
                      ),
                      SizedBox(height: 8),
                      BooleanAttribute(
                        label: 'Vegetarian',
                        value: meal.isVegetarian,
                      ),
                      SizedBox(height: 16),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> content) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            ...content,
          ],
        ),
      ),
    );
  }
}
