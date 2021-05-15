import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';

class MoviesPageWidget extends StatefulWidget {
  @override
  _MoviesPageWidgetState createState() => _MoviesPageWidgetState();
}

class _MoviesPageWidgetState extends State<MoviesPageWidget>{
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
        title: Text("Studio Ghibli movies"),
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
                    return ListItem(movies[i]);
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


class ListItem extends StatelessWidget {
  final MovieListItem item;

  const ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                item.imageUrl
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("${item.score} - ${item.aired.year} - ${item.members}")],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("${item.isFavorite}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


