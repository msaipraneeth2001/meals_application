import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isFavorite);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((thisone) => thisone.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title!),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          widget.isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => widget.toggleFavorite(mealId),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl as String,
                  fit: BoxFit.cover),
            ),

            buildSectionTitle(context, 'Ingredients'),

            buildContainer(ListView.builder(
              itemCount: selectedMeal.ingredients!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients![index]),
                  ),
                );
              },
            )),

            buildSectionTitle(context, 'Steps'),

            buildContainer(ListView.builder(
              itemCount: selectedMeal.steps!.length,
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(selectedMeal.steps![index]),
                  ),
                  const Divider(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Container buildContainer(Widget child) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(6.0),
      child: child,
    );
  }
}
