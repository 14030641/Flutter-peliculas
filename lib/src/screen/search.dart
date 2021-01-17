import 'package:flutter/material.dart';
import 'package:practica2/src/assets/configuration.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:practica2/src/network/api_search.dart';
import 'package:practica2/src/views/card_trending.dart';

class Search extends StatefulWidget {
  final String search;
  const Search({String search}) : this.search = search;
  @override
  _SearchState createState() => _SearchState(search: search);
}

class _SearchState extends State<Search> {
  ApiSearch apiSearch;
  _SearchState({this.search});
  final String search;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Configuration.colorMain,
        title: Text('Search'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Configuration.colorMain,
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
              future: getSearch(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('No hubo resultados'));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return _listTrending(snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  Future<List<Result>> getSearch() async {
    apiSearch = ApiSearch(query: search);
    List<Result> result = await apiSearch.getSearch();

    return result;
  }

  Widget _listTrending(List<Result> movies) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Result trending = movies[index];
        return CardTrending(trending: trending);
      },
      itemCount: movies.length,
    );
  }
}
