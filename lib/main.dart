

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api/MoviePage.dart';
import 'package:movie_api/widgets.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Movie> _movies = <Movie>[];

  @override
  void initState(){
    super.initState();
    populateAllMovies();
  }

  void populateAllMovies()async{
    final movies=await fetchMovies();
    setState(() {
      _movies=movies;
    });
  }

  Future<List<Movie>> fetchMovies()async{
    final response= await http.get(Uri.parse("https://www.omdbapi.com/?s=Batman&page=2&apikey=9634794d"));

    if(response.statusCode==200){
      final result=jsonDecode(response.body);
      Iterable list=result("Search");
      return list.map((movie)=>Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Failed to load movies");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("KK Box Office"),
          ),
          body: MoviesWidget(movies:_movies),
        ),
    );
  }
}

