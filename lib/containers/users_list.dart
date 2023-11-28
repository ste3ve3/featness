// ignore_for_file: file_names, use_build_context_synchronously
import 'package:featnessapp/models/user_details_model.dart';
import 'package:featnessapp/pages/add_user.dart';
import 'package:featnessapp/pages/home.dart';
import 'package:featnessapp/services/base_client.dart';
import 'package:featnessapp/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

Padding usersList(dynamic allUsers, BuildContext context, Function setState, bool detailsLoading) {
    final users = allUsers.data;
    final BaseClient baseClient = BaseClient();

    void getUserDetails(userId) async {
    try {
      setState(() {
        detailsLoading = true;
      });
      final ApiResponse<dynamic> response = await baseClient.get('/user/$userId');
      setState(() {
        detailsLoading = false;
      });
      if (response.status == Status.COMPLETED) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddUser(currentUser: userDetailsFromJson(response.rawResponse))),
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("${response.error}")),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 10),
            showCloseIcon: true,
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("$e")),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
          backgroundColor: Colors.black,
        ),
      );
    }
  }

    void deleteUser(userId) async {
    try {
      // setState(() {
      //   detailsLoading = true;
      // });
      final ApiResponse<dynamic> response = await baseClient.delete('/user/$userId');
      // setState(() {
      //   detailsLoading = false;
      // });
      if (response.status == Status.COMPLETED) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text("User deleted successfully!")),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 10),
            showCloseIcon: true,
            backgroundColor: Colors.black,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("${response.error}")),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 10),
            showCloseIcon: true,
            backgroundColor: Colors.black,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("$e")),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
          backgroundColor: Colors.black,
        ),
      );
    }
  }

    return Padding(
      padding: const EdgeInsets.only(left:20, right:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              reverse: true,
              itemBuilder: (context, index) {
                String fullName = "${users[index].firstName} ${users[index].lastName}";
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 40,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [ 
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(users[index].picture),
                              fit: BoxFit.cover
                            ),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName.length > 12 ? "${fullName.substring(0, 12)}..." : fullName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                "${users[index].title}@gmail.com",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Builder(
                        builder: (context) {
                          return GestureDetector(
                            child: const Icon(Icons.more_vert),
                            onTap: () {
                              showPopover(
                                context: context,
                                bodyBuilder: (context) => 
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: ListView(
                                    padding: const EdgeInsets.all(10),
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          getUserDetails(users[index].id);
                                        },
                                        child: Row(
                                        children: [
                                          detailsLoading ? 
                                            const SizedBox(
                                              width: 22.0,
                                              height: 22.0,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                              ),
                                            )
                                           : 
                                          const Icon(Icons.edit, color: Colors.green,),
                                          const SizedBox(width: 5,),
                                          const Text(
                                            "Edit",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],                                                                              ),
                                      ),
                                      const SizedBox(height: 15,),
                                      GestureDetector(
                                       onTap: () async {
                                          Navigator.pop(context);
                                          if (await confirmDialog(
                                            context,
                                            'Delete User?',
                                            'Are you sure that you want to delete this user?',
                                            'Delete',
                                            Colors.red
                                          ) ?? false) {
                                            deleteUser(users[index].id);
                                          }
                                          return debugPrint('pressedCancel');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.delete, color: Colors.red),
                                            SizedBox(width: 5,),
                                            Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                direction: PopoverDirection.bottom,
                                backgroundColor: Colors.white,
                                width: 120,
                                height: 95,
                                arrowHeight: 10,
                                arrowWidth: 20,
                              );
                            },
                          );
                        }
                      ),
                    )
                    ]
                  ),
                );
              }, 
              separatorBuilder: (context, index) => const SizedBox(height: 20,), 
              shrinkWrap: true,
              itemCount: users.length,
            ),
          )
        ]
      ),
    );
  }