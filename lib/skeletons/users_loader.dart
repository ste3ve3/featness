import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Padding usersLoader() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SingleChildScrollView(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.transparent,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            shrinkWrap: true,
            itemCount: 10,
          ),
        )
      ],
    ),
  );
}
