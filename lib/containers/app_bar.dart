import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar() {
    return AppBar(
      title: const Text(
        'FlipSide Users',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: 
      GestureDetector(
        onTap: () {
          
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
      actions: [
        GestureDetector(
          onTap: () {

          },
          child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/dots.svg',
            height: 5,
            width: 5,
          ),
        ))
      ],
    );
  }