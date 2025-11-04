import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/features/feeds/domain/entities/feed_entity.dart';
import 'package:social/features/feeds/presentation/pages/widgets/create_post_button.dart';
import '../../../../routes/app_router.dart';
import '../../../login/presentation/bloc/login_bloc.dart';
import '../bloc/feeds_bloc.dart';
import '../bloc/feeds_event.dart';
import '../bloc/feeds_state.dart';
import 'widgets/feed_card_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<FeedEntity> feeds = [];
  @override
  void initState() {
    context.read<FeedBloc>().add(FetchFeedsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Row(children: [const Icon(Icons.logout), SizedBox(width: 5), Text('Logout')]),
              onPressed: () {
                context.read<LoginBloc>().add(LogoutButtonPressed());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: PostFeedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.createFeed)),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginInitial) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeedError) {
              return Center(child: Text(state.message));
            } else if (state is FeedLoaded) {
              feeds = state.feeds;
            }
            if (feeds.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FeedBloc>().add(FetchFeedsEvent());
                },
                child: ListView.builder(
                  itemCount: feeds.length,
                  itemBuilder: (context, index) {
                    final feed = feeds[index];
                    return FeedCard(feed: feed);
                  },
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FeedBloc>().add(FetchFeedsEvent());
              },
              child: Container(height: MediaQuery.sizeOf(context).height, width: MediaQuery.sizeOf(context).width, color: Colors.black),
            );
          },
        ),
      ),
    );
  }
}
