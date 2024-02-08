import 'package:flutter/material.dart';
import 'package:weshot/components/shared/build_cached_image.dart';
import 'package:weshot/screens/post/post_model.dart';


class PostCardWrapper extends StatelessWidget {
  final PostFilter post;
  final Function()? onTap;

const PostCardWrapper({
    Key? key,
    required this.post,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.all(4), // Add some margin for spacing
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            buildCachedImagePlaceHolder(
              post.image,
              context,
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                post.categories!.map((c) => c.name).join(', '),
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
