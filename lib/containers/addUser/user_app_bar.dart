import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar userAppBar(BuildContext context, dynamic currentUser) {
    return AppBar(
      title: Text(
        currentUser != null ? 'Edit User' : 'Add New User',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: 
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/Arrow - Left 2.svg',
          height: 20,
          width: 20,
        ),
      )),
    );
  }