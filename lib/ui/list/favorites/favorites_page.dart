import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';
import 'package:flutter_hf/ui/details/details_page.dart';
import 'package:flutter_hf/ui/list/movie_list_item.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>{
  final _movieInteractor = MovieInteractor();
  Future<List<MovieListItem>>? moviesRequest;

  @override
  void initState() {
    moviesRequest = _movieInteractor.getMovies("start_date", "desc");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = _movieInteractor.getMovies("start_date", "desc");
          setState(() {
            moviesRequest = request;
          });
          await request;
        },
        child: FutureBuilder<List<MovieListItem>>(
            future: moviesRequest,
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(
                  child: Text(
                      "An error occurred: ${snapshot.error}"
                  ),
                );
              }

              if (snapshot.hasData){
                var movies = snapshot.data!;
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, i){
                    return ListItem(
                      movies[i],
                      onTap: (item) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailsPageWidget(item.malId)));
                      },
                    );
                  },
                  itemCount: movies.length,
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
      ),
    );
  }
}


