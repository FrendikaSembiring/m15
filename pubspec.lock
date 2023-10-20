import 'package:flutter/material.dart';
import 'package:my_project/HttpHelper.dart';
import 'package:my_project/KeywordChip.dart';
import import 'package:my_project/detail.dart';
import 'package:my_project/movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum MovieCategory {
  Latest,
  NowPlaying,
  Popular,
  TopRated,
  Upcoming,
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List<Movie>? movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  MovieCategory selectedCategory = MovieCategory.NowPlaying;
  TextEditingController searchController = TextEditingController(); // Add this line
  Future<void> initialize(MovieCategory category) async {
    helper = HttpHelper();
    String searchKeyword = searchController.text; // Get the search text
    movies = await helper?.getMoviesByCategory(category, searchKeyword);
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize(selectedCategory);

    // Set the initial search text (if needed)
    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: searchController, // Add this line
            onChanged: (value) {
              setState(() {
                // No need to update searchKeyword here
              });
              initialize(selectedCategory);
            },
            decoration: InputDecoration(
              hintText: 'Cari film...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          DropdownButton<MovieCategory>(
            value: selectedCategory,
            items: MovieCategory.values.map((category) {
              return DropdownMenuItem<MovieCategory>(
                value: category,
                child: Text(category.toString().split('.').last),
              );
            }).toList(),
            onChanged: (category) {
              setState(() {
                selectedCategory = category!;
              });
              initialize(category!);
            },
          ),
          SizedBox(height: 20),
          Text('Kata Kunci:'),
          Wrap(
            children: <Widget>[
              KeywordChip(
                'Horor',
                onDelete: () {
                  // Add logic here to remove the "Horor" keyword
                },
              ),
              KeywordChip(
                'Comedy',
                onDelete: () {
                  // Add logic here to remove the "Comedy" keyword
                },
              ),
              // Add other keywords as needed
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (movies?.length == null) ? 0 : movies!.length,
              itemBuilder: (BuildContext context, int position) {
                if (movies![position].posterPath != null) {
                  image = NetworkImage(iconBase + movies![position].posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => DetailScreen(movies![position]),
                      );
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies![position].title),
                    subtitle: Text('Released: ' +
                        movies![position].releaseDate +
                        ' - Vote: ' +
                        movies![position].voteAverage.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
