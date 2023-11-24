// ignore_for_file: file_names
import 'package:featnessapp/containers/app_bar.dart';
import 'package:featnessapp/containers/search_field.dart';
import 'package:featnessapp/models/category_model.dart';
import 'package:featnessapp/models/diet_model.dart';
import 'package:featnessapp/models/popular_model.dart';
import 'package:featnessapp/containers/users_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  List < CategoryModel > categories = [];
  List < DietModel > diets = [];
  List < PopularDietsModel > popularDiets = [];

  void _getInitialData() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialData();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          searchField(),
          const SizedBox(height: 20,),
          usersList(popularDiets),
          const SizedBox(height: 20,),
        ],
          ),
      );
  }
  
}