import 'package:flutter/material.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/pages/actor_detail/widgets/known_for_horizontal_item.dart';

class KnownForHorizontalList extends StatelessWidget {
  final List<KnownFor>? knownFor;
  const KnownForHorizontalList({super.key, required this.knownFor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: knownFor?.length,
        itemBuilder: (context, index) {
          final movie = knownFor?[index];
          return KnownForHorizontalItem(movie: movie);
        },
      ),
    );
  }
}
