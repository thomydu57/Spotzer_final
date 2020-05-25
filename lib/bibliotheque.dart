import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:dart_tags/dart_tags.dart';
import 'package:flutter/services.dart';
import 'package:id3/id3.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';
import 'package:mp3_info/mp3_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotzerfinal/main.dart';

import 'album.dart';
import 'appartenir.dart';
import 'artiste.dart';
import 'detenir.dart';
import 'genre.dart';
import 'morceau.dart';
import 'playlist.dart';

class Bibliotheque {
  static const int INCHANGE = 0;
  static const int CREE = 1;
  static const int MODIFIE = 2;
  static const int SUPPRIMER = 3;

  List<Artiste> listeArtistes = new List<Artiste>();
  List<Album> listeAlbums = new List<Album>();
  List<Morceau> listeMorceaux = new List<Morceau>();
  List<Genre> listeGenres = new List<Genre>();
  List<Playlist> listePlaylists = new List<Playlist>();
  List<String> listeImports = new List<String>();
  AlbumBean albumBean;
  ArtisteBean artisteBean;
  GenreBean genreBean;
  PlaylistBean playlistBean;
  MorceauBean morceauBean;
  AppartenirBean appartenirBean;
  DetenirBean detenirBean;
  PgAdapter adapter;
  BeanRepo beanRepo;
  int isalbum;
  int isartiste;
  int ismorceau;

  Bibliotheque() {
    isalbum = 0;
    isartiste = 0;
    ismorceau = 0;
    adapter =
        PgAdapter('postgres', username: 'postgres', password: 'password1234');
    beanRepo = BeanRepo();

    albumBean = AlbumBean(adapter, beanRepo);
    artisteBean = ArtisteBean(adapter, beanRepo);
    genreBean = GenreBean(adapter, beanRepo);
    playlistBean = PlaylistBean(adapter, beanRepo);
    morceauBean = MorceauBean(adapter, beanRepo);
    appartenirBean = AppartenirBean(adapter, beanRepo);
    detenirBean = DetenirBean(adapter, beanRepo);

    beanRepo.addAll([
      albumBean,
      artisteBean,
      genreBean,
      playlistBean,
      morceauBean,
      appartenirBean,
      detenirBean
    ]);

    listeImports.add("Chill_Trap.mp3");
    listeImports.add("Gerard.mp3");
    listeImports.add("Poison.mp3");
    listeImports.add("Une_Etincelle.mp3");


  }

  Future<void> connexionEtTralala()
  async {
    await connect();
    await viderBase();
    await creerTable();
    await creerGenre();
    await chargerDbenMetier();
  }

  Future<void> connect() async {
    await adapter.connect();
  }

  void afficherLesgenres() {
    for (var g in listeGenres) {
      print(g);
    }
  }

  Future<void> sauvegarderMetierEnDb() async {

    for(var morceau in listeMorceaux){
      switch(morceau.getEtatMetier){
        case CREE: await morceauBean.insert(morceau, cascade:true);
                    morceau.setEtatMetier = Bibliotheque.INCHANGE;
                    break;
        case MODIFIE: await morceauBean.update(morceau, cascade: true);
                      break;
        case SUPPRIMER: await morceauBean.remove(morceau.getCodeMorceau);
                        break;
      }
      
    }

    /*for (var artiste in listeArtistes) {
      await artisteBean.insert(artiste, cascade: true);
    }
    for (var album in listeAlbums) {
      await albumBean.insert(album, cascade: true);
    }*/
    /*listeAlbums.clear();
    listeArtistes.clear();
    listeAlbums = await albumBean.getAll();
    listeArtistes = await artisteBean.getAll();*/

    /*for (var morceau in listeMorceaux) {
      for (var album in listeAlbums) {
        if (morceau.album.equalsSansCode(album)) {
          morceau.albumMorceau = album.codeAlbum;
        }
      }
      for (var artiste in listeArtistes) {
        if (morceau.artiste.equalsSansCode(artiste)) {
          morceau.artisteMorceau = artiste.codeArtiste;
        }
      }
      await morceauBean.insert(morceau);
    }*/

    /*for(var g in listeGenres){
      for(var m in g.getMorceauxGenre){
        if(m != null){
          g.getMorceauxGenre.clear();
          await morceauBean.getAll();
        }
      }

    }
    for(var morceau in listeMorceaux){
      await detenirBean.attach(morceau, genre)
    }*/
    

    /*for (var playlist in listePlaylists) {
      await playlistBean.insert(playlist);
    }*/
  }

  Future<void> viderBase() async {
    await appartenirBean.drop();
    await detenirBean.drop();
    await genreBean.drop();
    await playlistBean.drop();
    await morceauBean.drop();
    await artisteBean.drop();
    await albumBean.drop();
  }

  Future<void> creerTable() async {
    await albumBean.createTable();
    await artisteBean.createTable();
    await genreBean.createTable();
    await playlistBean.createTable();
    await morceauBean.createTable();
    await appartenirBean.createTable();
    await detenirBean.createTable();
  }

  Future<void> chargerDbenMetier() async {
    listeArtistes = await artisteBean.getAll();
    listeAlbums = await albumBean.getAll();
    listeGenres = await genreBean.getAll();
    listePlaylists = await playlistBean.getAll();
    listeMorceaux = await morceauBean.getAll();
    //afficherLesgenres();
  }

  Future<void> creerGenre() async {
    Genre g = new Genre();
    var lg =await  g.creerGenre(); // Les libelles du genre sont dans le tableau
    for (var g in lg) {
      await genreBean.insert(g); // On insère dans la db les genres
    }
  }

  void close() {
    adapter.close();
  }


  Future<Uri> uriMusic(String s)async {
    final ByteData data = await rootBundle.load('assets/'+s);
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/'+s);
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempFile.uri;
  }


  Future<void> ajouterUnMorceau(String mp3) async {
    File filemp3 = new File.fromUri(await uriMusic(mp3));

    Artiste artistemp3;
    Album albummp3 = null;
    List<Genre> genresmp3 = new List<Genre>();
    Morceau morceaump3 = new Morceau.vide();
    morceaump3.setCodeMorceau = ismorceau;
    ismorceau += 1;

    await TagProcessor().getTagsFromByteArray(filemp3.readAsBytes()).then((l) {

      print('FILE: $filemp3');

      // completion de l'artiste
      var nomArtiste = l[1].tags['artist'];
      nomArtiste ??= l[0].tags['artist'];
      print(nomArtiste);
      nomArtiste = nomArtiste.trim();
      print('Artiste : ' + nomArtiste);
      if (nomArtiste != '') {
        var trouve = false;
        for (var a in listeArtistes) {
          // On parcourt la liste des artistes pour savoir si il n'existe pas déjà, si on ne le trouve pas on l'ajoute
          if (a.getNomArtiste == nomArtiste) {
            artistemp3 = a;
            trouve = true;
          }
        }
        if (!trouve) {
          artistemp3 = new Artiste(nomArtiste,isartiste);
          isartiste += 1;
          listeArtistes.add(artistemp3);
        }
      }

      var titreAlbum = l[1].tags['album'];
      titreAlbum ??= l[0].tags['album'];
      print('titre album :' + titreAlbum);
      var anneeAlbum = l[1].tags['TDRC'];
      anneeAlbum ??= l[1].tags['year'];
      anneeAlbum ??= l[0].tags['TDRC'];
      anneeAlbum ??= l[0].tags['year'];
      anneeAlbum = int.parse(anneeAlbum);
      print('annee album :  $anneeAlbum');
      var trouve = false;
      for (var a in listeAlbums) {
        if (a.getTitreAlbum == titreAlbum) {
          albummp3 = a;
          trouve = true;
        }
      }
      if (!trouve) {
        albummp3 = new Album(titreAlbum, anneeAlbum,isalbum);
        isalbum += 1;
        listeAlbums.add(albummp3);
      }

        var genres = new List<String>();
        var regex = RegExp(r'^[(]');
        if (regex.stringMatch(l[1].tags['genre'].toString()) != null) {
          print("C'est un Byte");
          genres.add(l[1].tags['genre']);
          print(genres);
          for (var genre in genres) {
            try {
              if (genre.isNotEmpty) {
                var trouve = false;
                var numGenre = -1;
                try {
                  numGenre = int.parse(genre.substring(
                      1,
                      genre.length -
                          1)); //Byte.parseByte(genre.substring(1, genre.length - 1));
                  print('Le numGenre est : ' + numGenre.toString());
                } catch (e) {
                  e.toString();
                }
                for (var g in listeGenres) {
                  if (g.getCodeGenre - 1 == numGenre) {
                    genresmp3.add(g);
                    trouve = true;
                  }
                  if (genre == g.getLibelleGenre) {
                    genresmp3.add(g);
                    trouve = true;
                  }
                }
                if (!trouve) {
                  print("ce genre n'existe pas");
                }
              }
            } catch (e) {
              print('Genre inconnu');
            }
          }
        } else {
          var trouve = false;
          print("C'est un string");
          var s = l[1].tags['genre'].toString();
          genres = s.split(',');
          print(genres);
          for (var genre in genres) {
            genre.trim();
            for (var g in listeGenres) {
              if (genre == g.getLibelleGenre) {
                genresmp3.add(g);
                trouve = true;

              }
            }
            if (!trouve) {
              print("ce genre n'existe pas");
            }
          }
        }
        print('Les genres sont : ' +genresmp3.toString());

      try {
        morceaump3.setTitreMorceau(l[1].tags['title'].toString());
        print('titre morceau : ' + morceaump3.titreMorceau);
      } catch (e) {
        e.printStackTrace();
      }
      try {
        morceaump3.setCommentaireMorceau(l[1].tags['comment'].toString());
        print('commentaire du morceau : ' + morceaump3.commentaireMorceau);
      } catch (e) {
        e.printStackTrace();
      }
      var anneeMorceau = l[1].tags['TDRC'];
      anneeMorceau ??= l[1].tags['year'];
      anneeMorceau ??= l[0].tags['TDRC'];
      anneeMorceau ??= l[0].tags['year'];
      anneeMorceau = int.parse(anneeMorceau);
      morceaump3.setAnneeMorceau(anneeMorceau);
      print('Annee morceau : ' + morceaump3.anneeMorceau.toString());
      try {
        morceaump3.setParolesMorceau('');
      } catch (e) {
        e.printStackTrace();
      }
      try {
        morceaump3.setAuteurCompositeurMorceau('');
      } catch (e) {
        e.printStackTrace();
      }
      // Chemin Morceau
      morceaump3.cheminMorceau = filemp3.toString();
      
      morceaump3.cheminMorceau=morceaump3.cheminMorceau.replaceAll('import', 'bibliotheque');
      morceaump3.cheminMorceau=morceaump3.cheminMorceau.replaceAll('File: \'','');
      //morceaump3.cheminMorceau=morceaump3.cheminMorceau.substring(0,morceaump3.cheminMorceau.length-1);
      print('NOUVEAU CHEMIN'+morceaump3.cheminMorceau);
      /*try {
				File rep = new File("./bibliotheque");
        
				File fileApresDeplacement = new File(rep, mp3.getName());
				mp3.renameTo(fileApresDeplacement);
				String cheminAbsolu = fileApresDeplacement.getAbsolutePath();
				String[] decoup = cheminAbsolu.split("NewSpotzer");
				String cheminRelatif = decoup[1].substring(1, decoup[1].length());
				morceaump3.setCheminMorceau(cheminRelatif);
			} catch (Exception e) {
				e.printStackTrace();
			}*/



      try {
        morceaump3.setAlbum(albummp3);
      } catch (e) {
        e.printStackTrace();
      }

      try {
        morceaump3.setArtiste(artistemp3);
      } catch (e) {
        e.printStackTrace();
      }

      /*try {
        morceaump3.setGenresMorceau(genresmp3);
      } catch (e) {
        e.printStackTrace();
      }*/
      //morceaump3.albumMorceau = albummp3.codeAlbum;
      //morceaump3.artisteMorceau = artistemp3.codeArtiste;

      if (artistemp3 != null) {
        artistemp3.getMorceauxArtiste.add(morceaump3);
      }
      if (albummp3 != null) {
        albummp3.getMorceauxAlbum.add(morceaump3);
      }
      for (var g in genresmp3) {
        morceaump3.ajoutGenreMorceau(g);
        g.getMorceauxGenre.add(morceaump3);
      }
      morceaump3.setEtatMetier = Bibliotheque.CREE;
      listeMorceaux.add(morceaump3);
      /*for(var l in listeMorceaux){
        print(l);
      }
      for(var a in listeAlbums){
        print(a);
      }
      for(var ar in listeArtistes){
        print(ar);
      }*/
    });
    //await filemp3.rename(morceaump3.cheminMorceau);
  }

  /////////////////
  //// GETTERS ////
  /////////////////

  List<Artiste> get getListArtistes => listeArtistes;
  List<Album> get getListAlbums => listeAlbums;
  List<Morceau> get getListMorceaux => listeMorceaux;
  List<Genre> get getListGenres => listeGenres;
  List<Playlist> get getListPlaylists => listePlaylists;


}
