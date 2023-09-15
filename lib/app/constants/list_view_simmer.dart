import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'color_constnts.dart';

class ListViewSimmer extends StatelessWidget {
  const ListViewSimmer({this.wrap = false, super.key,this.widget});
  final  Widget? widget;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.greyScaleDark7,
      highlightColor: ColorConstants.greyScaleDark6,
      child: ListView.builder(
          shrinkWrap: wrap,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, _) =>widget ?? _buildShimmerContent()),
    );
  }

  Widget _buildShimmerContent() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerImage(),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerText(10.0),
                const SizedBox(height: 5.0),
                _buildShimmerText(8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerImage() {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildShimmerText(double fontSize) {
    return ShimmerText(fontSize: fontSize);
  }
  static Widget card(){
    return Container(

    );
  }
}


class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key,required this.fontSize});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: fontSize + 4.0,
      color: Colors.grey[300],
    );
  }
}