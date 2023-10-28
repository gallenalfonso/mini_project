import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class NewsComponent extends StatelessWidget {
  final String? newsTitle , newsimage;
  const NewsComponent({super.key, this.newsTitle , this.newsimage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
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
