// ignore_for_file: file_names
import 'package:featnessapp/containers/app_bar.dart';
import 'package:featnessapp/containers/bottom_sheet.dart';
import 'package:featnessapp/containers/search_field.dart';
import 'package:featnessapp/models/popular_model.dart';
import 'package:featnessapp/containers/users_list.dart';
import 'package:featnessapp/models/users_model.dart';
import 'package:featnessapp/services/base_client.dart';
import 'package:featnessapp/skeletons/users_loader.dart';
import 'package:featnessapp/widgets/data_checker.dart';
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            searchField(),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left:20, right:20),
              child: BottomSheetContainer(
              padding: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "Add User",
                style: TextStyle(color: Colors.white),
              ),
                        ),
            ),
            const SizedBox(height: 20,),
            FutureBuilder<ApiResponse<dynamic>>(
              future: baseClient.get('/user?created=1'),
              builder: (context, snapshot) {
                  bool isLoading = snapshot.connectionState == ConnectionState.waiting;
                  bool isError = snapshot.hasError;
                  bool isEmpty = !isLoading && !isError && (snapshot.data != null && usersFromJson(snapshot.data!.data).data.isEmpty);
                  return DataChecker(
                    title: 'Users',
                    isLoading: isLoading,
                    isError: isError ? '${snapshot.error}' : null,
                    isEmpty: isEmpty,
                    customLoaderIndicator: usersLoader(),
                    children: (isLoading || isError) ? Container() : usersList(usersFromJson(snapshot.data!.data)),
                  );
                },
            ),
            const SizedBox(height: 20,),
          ],
            ),
      ),
      );
  }
  
}