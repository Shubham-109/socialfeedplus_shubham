import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../domain/entities/comment_entity.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/feeds_bloc.dart';
import '../../bloc/feeds_event.dart';
import '../../bloc/feeds_state.dart';

void showCommentsBottomSheet(BuildContext context, String feedId) {
  final commentController = TextEditingController();
  List<CommentEntity> comments = [];
  context.read<FeedBloc>().add(FetchCommentsEvent(feedId));

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 10),
                const Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Divider(thickness: .5, color: Color(0xff323232)),
                ),
                Expanded(
                  child: BlocConsumer<FeedBloc, FeedState>(
                    listener: (context, state) {
                      if (state is FeedLoaded) {}
                    },
                    builder: (context, state) {
                      print(state.toString());
                      if (state is CommentsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CommentsLoaded && state.feedId == feedId) {
                        comments = state.comments;
                      }
                      if (state is CommentsError) {
                        return Center(child: Text(state.message));
                      }

                      if (comments.isEmpty) {
                        return const Center(child: Text("No comments yet. Be the first!"));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(comment.userId, style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text(comment.text),
                            trailing: Text(_timeAgo(comment.commentedAt), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Divider(thickness: .5, color: Color(0xff323232)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              controller: commentController,
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                hintText: "Add a comment...",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send_rounded, color: Colors.blueAccent),
                                  onPressed: () {
                                    final text = commentController.text.trim();
                                    if (text.isEmpty) return;
                                    final newComment = CommentEntity(
                                      id: const Uuid().v4(),
                                      feedId: feedId,
                                      userId: '',
                                      text: text,
                                      commentedAt: DateTime.now(),
                                    );
                                    context.read<FeedBloc>().add(AddCommentEvent(newComment));
                                    commentController.clear();
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              cursorColor: Colors.blueAccent,
                              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    },
  );
}

String _timeAgo(DateTime dateTime) {
  return timeago.format(dateTime);
}
