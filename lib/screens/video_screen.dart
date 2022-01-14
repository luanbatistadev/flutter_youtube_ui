import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/data.dart';
import 'package:flutter_youtube_ui/screens/nav_screen.dart';
import 'package:flutter_youtube_ui/widgets/widgets.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read(miniplayerControllerProvider)
          .state
          .animateToHeight(state: PanelState.MAX),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomScrollView(
              controller: _scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context, watch, child) {
                      final selectedVideo = watch(selectedVideoProvider).state;
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                selectedVideo!.thumbnailUrl,
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                onPressed: () => context
                                    .read(miniplayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                iconSize: 30,
                              ),
                            ],
                          ),
                          const LinearProgressIndicator(
                            value: 0.4,
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                          ),
                          VideoInfo(video: selectedVideo)
                        ],
                      );
                    },
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final video = suggestedVideos[index];
                  return VideoCard(
                    video: video,
                    hasPadding: true,
                    onTap: () => _scrollController!.animateTo(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn),
                  );
                }, childCount: suggestedVideos.length))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
