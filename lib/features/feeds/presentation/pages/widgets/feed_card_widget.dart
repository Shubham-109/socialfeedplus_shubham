import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../domain/entities/feed_entity.dart';
import '../../../domain/entities/like_entity.dart';
import '../../bloc/feeds_bloc.dart';
import '../../bloc/feeds_event.dart';
import 'comments_bottom_sheet.dart';

class FeedCard extends StatelessWidget {
  final FeedEntity feed;

  const FeedCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff323232), width: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/100', // replace with feed.userProfileUrl if available
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Shubham Mehar",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ),
                      Row(
                        children: [Text("${timeago.format(feed.createdAt)} • India", style: TextStyle(color: Colors.grey, fontSize: 12))],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Caption ---
          if (feed.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                feed.caption,
                style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          SizedBox(height: 15),
          // --- Image Section with Overlayed Stats ---
          if (feed.imageUrl.isNotEmpty)
            CachedNetworkImage(imageUrl: feed.imageUrl, fit: BoxFit.cover, width: double.infinity, height: MediaQuery.sizeOf(context).width * 0.9),

          // --- Bottom Interaction Row ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    feed.isLikedByCurrentUser ? Icons.favorite : Icons.favorite_border,
                    color: feed.isLikedByCurrentUser ? Colors.redAccent : Colors.grey,
                  ),
                  onPressed: () {
                    context.read<FeedBloc>().add(LikeFeedEvent(LikeEntity(feedId: feed.id, likedAt: DateTime.now())));
                  },
                ),
                Text("${feed.likesCount}", style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 20),
                const Icon(Icons.comment_outlined, size: 22, color: Colors.grey),
                const SizedBox(width: 4),
                Text("${feed.commentsCount}", style: const TextStyle(color: Colors.grey)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showCommentsBottomSheet(context, feed.id);
                  },
                  child: const Text("View comments"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
