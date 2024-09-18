import 'package:flutter/material.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/pages/top_rated/widgets/popular_actors.dart';
import 'package:movie_app/services/api_services.dart';

class PopularActorsPage extends StatefulWidget {
  const PopularActorsPage({super.key});

  @override
  State<PopularActorsPage> createState() => _PopularActorsPageState();
}

class _PopularActorsPageState extends State<PopularActorsPage> {
  ApiServices apiServices = ApiServices();

  late Future<ActorResult> popularActors;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    popularActors = apiServices.getActors();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Actors'),
      ),
      body: FutureBuilder<ActorResult>(
        future: popularActors,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.results?.length,
              itemBuilder: (context, index) {
                var actor = snapshot.data!.results?[index];
                return PopularActors(actor: actor);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}