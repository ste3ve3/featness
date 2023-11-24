// ignore_for_file: file_names
import 'package:featnessapp/containers/bottom_sheet.dart';
import 'package:featnessapp/models/popular_model.dart';
import 'package:featnessapp/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

Padding usersList(List<PopularDietsModel> popularDiets) {
    return Padding(
      padding: const EdgeInsets.only(left:20, right:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const BottomSheetContainer(
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
          const SizedBox(height: 20,),
          ListView.separated(
            itemBuilder: (context, index) {
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
                          image: const DecorationImage(
                            image: NetworkImage('https://lh3.googleusercontent.com/a/AGNmyxbsEy7JSTGCaqtDN6xBs9LmnTU7ngsaQFeJOmFz=s96-c'),
                            fit: BoxFit.cover
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDiets[index].name.length > 20 ? "${popularDiets[index].name.substring(0, 20)}..." : popularDiets[index].name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            popularDiets[index].level.length > 20 ? "${popularDiets[index].level.substring(0, 20)}..." : popularDiets[index].level,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
                                    const BottomSheetContainer(
                                      child: Row(
                                      children: [
                                        Icon(Icons.edit, color: Colors.green,),
                                        SizedBox(width: 5,),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          return debugPrint('pressedOK');
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
            itemCount: popularDiets.length,
          )
        ]
      ),
    );
  }