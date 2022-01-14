import 'package:flutter/material.dart';

import '../data.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image.asset('assets/yt_logo_dark.png'),
      ),
      actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.cast),
        ),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          iconSize: 40,
          onPressed: () => {},
          icon: CircleAvatar(
            foregroundImage: NetworkImage(currentUser.profileImageUrl),
          ),
        ),
      ],
    );
  }
}
