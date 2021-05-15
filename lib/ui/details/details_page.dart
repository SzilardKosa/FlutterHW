import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_details.dart';
import 'package:flutter_hf/domain/movie_interactor.dart';

class DetailsPageWidget extends StatefulWidget {
  final int movieId;

  DetailsPageWidget(this.movieId);

  @override
  _DetailsPageWidgetState createState() => _DetailsPageWidgetState(movieId);
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {
  final int movieId;
  final _movieInteractor = MovieInteractor();

  Future<MovieDetails>? detailsRequest;

  _DetailsPageWidgetState(this.movieId);

  @override
  void initState() {
    detailsRequest = _movieInteractor.getDetails(movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = _movieInteractor.getDetails(movieId);
          setState(() {
            detailsRequest = request;
          });
          await request;
        },
        child: FutureBuilder<MovieDetails>(
            future: detailsRequest,
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(
                  child: Text(
                      "An error occurred: ${snapshot.error}"
                  ),
                );
              }

              if (snapshot.hasData){
                var details = snapshot.data!;
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.title,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                        ),

                        SizedBox(height: 10,),

                        Row(
                          children: [
                            Image.network(
                              details.imageUrl,
                              height: 200,
                              width: 150,
                              fit: BoxFit.fill,
                            ),

                            SizedBox(width: 10,),

                            SizedBox(
                              height: 200,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.star),
                                      Text(
                                        details.score.toString(),
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(Icons.people),
                                      Text(
                                        details.members.toString(),
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),

                                  Spacer(),

                                  Text(
                                    "Aired",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    details.aired.year.toString(),
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Rated",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    details.rated,
                                    style: TextStyle(fontSize: 25),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: 10,),

                        Text(
                          "Synopsis",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 10,),

                        Text(
                          details.synopsis,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                      ],
                    ),
                  ),
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
