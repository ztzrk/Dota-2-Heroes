import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildSkeletonLoadingScreen() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: 10,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
    itemBuilder: (BuildContext context, int index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: 200,
          color: Colors.white,
        ),
      );
    },
  );
}
