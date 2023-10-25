import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class newsComponent extends StatelessWidget {
  final String? newsTitle , newsimage;
  const newsComponent({super.key, this.newsTitle , this.newsimage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 150,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: FancyShimmerImage(
                  boxFit: BoxFit.cover,
                  imageUrl: newsimage ?? ""),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              newsTitle ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
