import 'package:flutter/material.dart';
import 'package:geeksynergymt/core/colors/colors.dart';
import 'package:geeksynergymt/data/apifunctions/api_function.dart';
import 'package:geeksynergymt/data/models/movie_model.dart';
import 'package:geeksynergymt/presentation/home/widgets/info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showCompanyInfoDialog(context);
            },
            icon: const Icon(Icons.info, color: kwhite),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: FutureBuilder<List<Movie>>(
          future: ApiService().fetchMovies(
            category: 'movies',
            language: 'kannada',
            genre: 'all',
            sort: 'voting',
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No movies found.'));
            } else {
              final movies = snapshot.data!;

              return ListView.separated(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return SizedBox(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.arrow_upward_rounded),
                                  ),
                                  Text('${movie.totalVoted}'),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.arrow_downward_rounded),
                                  ),
                                  const Text('Votes')
                                ],
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    movie.poster,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(movie.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Genre: ${movie.genre}'),
                                    Text('Director: ${movie.director}'),
                                    Text('Stars: ${movie.stars}'),
                                    Text(movie.language),
                                    Text(
                                      'Voted by ${movie.voting} people',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  child: const Text('Watch Trailer'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                    height: 15.0,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
