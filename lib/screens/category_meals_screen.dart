import 'package:flutter/material.dart';
import '/model/meal.dart';
import '/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal>? availableMeals;
  const CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool _loadedInitData = false;

  _removeMeal(String mealId){
    setState(() {
      displayedMeals!.removeWhere((thisone) => thisone.id == mealId);
    });
  }

 @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String , String?>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals!.where((thisone){
        return thisone.categories!.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: ListView.builder(
        itemCount: displayedMeals!.length,
        itemBuilder: (context, index) => MealItem(
          id: displayedMeals![index].id,
          title: displayedMeals![index].title,
          imageUrl: displayedMeals![index].imageUrl,
          duration: displayedMeals![index].duration,
          complexity: displayedMeals![index].complexity,
          affordability: displayedMeals![index].affordability,
        ),
      ),
    );
  }
}
