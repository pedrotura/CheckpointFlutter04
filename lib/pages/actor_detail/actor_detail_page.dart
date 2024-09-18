import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/actor_detail_model.dart';
import 'package:movie_app/models/actor_model.dart';
import 'package:movie_app/pages/actor_detail/widgets/known_for_horizontal_list.dart';
import 'package:movie_app/services/api_services.dart';

class ActorDetailPage extends StatefulWidget {
  final int actorId;
  final List<KnownFor>? movies;
  const ActorDetailPage({super.key, required this.actorId, required this.movies});

  @override
  State<ActorDetailPage> createState() => _ActorDetailPageState();
}

class _ActorDetailPageState extends State<ActorDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<ActorDetail> actorDetail;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    actorDetail = apiServices.getActorDetail(widget.actorId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: actorDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final actor = snapshot.data;
              final age = DateTime.now().year - DateTime.parse(actor?.birthday ?? '2024-08-19').year;

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${actor?.profilePath}"),
                                fit: BoxFit.cover)),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          age != 0 ? '${actor?.name} - $age' : actor?.name ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          actor?.placeOfBirth ?? '',
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          actor?.biography ?? '',
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                        child: Text(
                          "Known for",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      KnownForHorizontalList(knownFor: widget.movies)
                    ],
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
