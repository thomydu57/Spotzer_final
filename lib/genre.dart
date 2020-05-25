import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';


import 'detenir.dart';
import 'morceau.dart';
part 'genre.jorm.dart';
class Genre {
  ////////////////
  //// FIELDS ////
  ////////////////

  @PrimaryKey(auto: true, isNullable: false)
  int codeGenre;

  @Column(isNullable: false)
  String libelleGenre;
  
  @ManyToMany(DetenirBean, MorceauBean)
  List<Morceau> morceauxGenre;
  
  static List<String> genres;
  
  static const String tableName = 'genre';
  
    //////////////////////
    //// CONSTRUCTORS ////
    //////////////////////
    
    Genre(){
      morceauxGenre = new List<Morceau>();
    }
    
  
    Genre.lib(String libelleGenre) {
      morceauxGenre = new List<Morceau>();
      this.libelleGenre = libelleGenre;
    }
  
    /////////////////
    //// GETTERS ////
    /////////////////
  
    int get getCodeGenre => codeGenre;
    String get getLibelleGenre => libelleGenre;
    List<Morceau> get getMorceauxGenre => morceauxGenre;
    static List get getGenres => genres;
  
    //////////////////
    //// SETTERS ////
    ////////////////
  
    set setCodeGenre(int code) => this.codeGenre = code;
    set setLibelleGenre(String libelle) => this.libelleGenre = libelle;
    set setMorceauxGenre(List<Morceau> morceau) => this.morceauxGenre = morceau;
    static set setGenres(List<String> genres) => Genre.genres = genres;
  
    ////////////////////////////////
    /// AJOUTER RETIRER PRESENCE ///
    ////////////////////////////////
  
    void ajoutMorceauGenre(Morceau m) {
      morceauxGenre.add(m);
    }
  
    void retirerMorceauGenre(Morceau m) {
      morceauxGenre.remove(m);
    }
  
    bool presenceMorceauGenre(Morceau m) {
      return morceauxGenre.contains(m);
    }
  
    ///////////////////////
    // EQUALS & TOSTRING //
    ///////////////////////
  
    @override
    bool operator ==(Object o) {
      if (identical(this, o)) return true;
  
      return o is Genre &&
          o.codeGenre == codeGenre &&
          o.libelleGenre == libelleGenre;
    }
  
    @override
    int get hashCode => codeGenre.hashCode ^ libelleGenre.hashCode;
  
    @override
    String toString() =>
        'Genre(codeGenre: $codeGenre, libelleGenre: $libelleGenre)';


  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/genres.txt');
  }

  Future<List<Genre>> creerGenre() async {
    String n = await loadAsset();
    List<String> l=n.split('\n');
    List<Genre> res = new List<Genre>();
    for(String s in l)
    {
      res.add(new Genre.lib(s));
    }
    return res;
  }

  /*static List<Genre> creerGenre() {
    final l = File('./assets/genres.txt').readAsLinesSync();
    List<Genre> res = new List<Genre>();
    for(String s in l)
    {
      res.add(new Genre.lib(s));
    }
    return res;
  } */


}



@GenBean()
class GenreBean extends Bean<Genre> with _GenreBean {
  final BeanRepo beanRepo;
  GenreBean(Adapter adapter, this.beanRepo) : super(adapter);

  String get tableName => 'genre';



}



