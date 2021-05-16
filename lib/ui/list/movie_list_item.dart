import 'package:flutter/material.dart';
import 'package:flutter_hf/domain/model/movie_listitem.dart';

class ListItem extends StatelessWidget {
  final MovieListItem item;
  final Function(MovieListItem item) onTap;

  const ListItem(
  this.item, {
    required this.onTap,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(item),
        child:  Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                item.imageUrl,
                height: 120,
                width: 90,
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 120,
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Date: ${item.aired.year}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Text("Rating: ${item.score}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 8),
                                    Text("Views: ${item.members}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            IconButton(
                                iconSize: 36,
                                icon: item.isFavorite ?
                                Icon(Icons.favorite, color: Colors.pink.shade500,) :
                                Icon(Icons.favorite_border, color: Colors.pink.shade500,),
                                onPressed: (){}
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}