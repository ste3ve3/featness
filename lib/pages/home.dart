// ignore_for_file: file_names
import 'package:featnessapp/containers/app_bar.dart';
import 'package:featnessapp/containers/search_field.dart';
import 'package:featnessapp/models/popular_model.dart';
import 'package:featnessapp/containers/users_list.dart';
import 'package:featnessapp/models/users_model.dart';
import 'package:featnessapp/services/base_client.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  List < PopularDietsModel > popularDiets = [];
  final baseClient = BaseClient();

  void _getInitialData() {
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialData();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchField(),
            const SizedBox(height: 20,),
            FutureBuilder<ApiResponse<dynamic>>(
              future: baseClient.get('/user'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final users = usersFromJson(snapshot.data?.data);
                  return usersList(users);
                }
              },
            ),
            const SizedBox(height: 20,),
          ],
            ),
      ),
      );
  }
  
}