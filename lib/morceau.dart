import 'package:jaguar_orm/jaguar_orm.dart';

import 'detenir.dart';

import 'album.dart';
import 'appartenir.dart';
import 'artiste.dart';
import 'bibliotheque.dart';
import 'genre.dart';
import 'playlist.dart';

part 'morceau.jorm.dart';

class Morceau {
  @PrimaryKey(isNullable: false)
  int codeMorceau;

  @Column(length: 30, isNullable: true)
  String titreMorceau;

  @BelongsTo.many(ArtisteBean, refCol: 'codeArtiste')
  int codeArtisteMorceau;

  @IgnoreColumn()
  Artiste artiste;

  @IgnoreColumn()
  Album album;

  @BelongsTo.many(AlbumBean, refCol: 'codeAlbum')
  int codeAlbumMorceau;

  @ManyToMany(DetenirBean, GenreBean)
  List<Genre> genresMorceau;

  @ManyToMany(AppartenirBean,PlaylistBean)
  List<Playlist> playlistsMorceau;

  @Column(length: 150)
  String cheminMorceau;

  @Column(isNullable: true)
  int anneeMorceau;

  @Column(length: 1500, isNullable: true)
  String parolesMorceau;

  @Column(length: 100, isNullable: true)
  String auteurCompositeurMorceau;

  @Column(length: 500, isNullable: true)
  String commentaireMorceau;

  static const tableName = 'morceau';

  @IgnoreColumn()
  int etatMetier;

  Morceau(int codeMorceau){
    this.codeMorceau = codeMorceau;
    genresMorceau = new List<Genre>();
    playlistsMorceau = new List<Playlist>();
    etatMetier = Bibliotheque.CREE;
  }

  Morceau.vide(){
    genresMorceau = new List<Genre>();
    playlistsMorceau = new List<Playlist>();
    etatMetier = Bibliotheque.CREE;
  }


  /////////////////
  //// GETTERS ////
  /////////////////

  int get getCodeMorceau => codeMorceau;

  String get getTitreMorceau => titreMorceau;

  int get getAlbumMorceau => codeAlbumMorceau;

  int get getArtisteMorceau => codeArtisteMorceau;

  List<Genre> get getGenres => genresMorceau;

  List<Playlist> get getPlaylists => playlistsMorceau;

  String get getCheminMorceau => cheminMorceau;

  int get getAnneeMorceau => anneeMorceau;

  String get getParolesMorceau => parolesMorceau;

  String get getAuteurCompositeurMorceau => auteurCompositeurMorceau;

  String get getCommentaireMorceau => commentaireMorceau;

  int get getEtatMetier => etatMetier;


  //////////////////
  //// SETTERS ////
  ////////////////

  set setCodeMorceau(int codeMorceau) => this.codeMorceau = codeMorceau;
  void setTitreMorceau(String titreMorceau) {this.titreMorceau = titreMorceau;etatMetier = Bibliotheque.MODIFIE;}
  void setAlbumMorceau(int albumMorceau) {this.codeAlbumMorceau = albumMorceau;etatMetier = Bibliotheque.MODIFIE;}
  void setArtisteMorceau(int artisteMorceau) {this.codeArtisteMorceau = artisteMorceau;etatMetier = Bibliotheque.MODIFIE;}
  void setGenresMorceau(List<Genre> genresMorceau) {this.genresMorceau = genresMorceau;etatMetier = Bibliotheque.MODIFIE;}
  void setCheminMorceau(String cheminMorceau){this.cheminMorceau = cheminMorceau;}
  void setAnneeMorceau(int anneeMorceau){this.anneeMorceau = anneeMorceau;}
  void setAuteurCompositeurMorceau(String auteurCompositeurMorceau){this.auteurCompositeurMorceau = auteurCompositeurMorceau;}
  void setCommentaireMorceau(String commentaireMorceau) {this.commentaireMorceau = commentaireMorceau;etatMetier = Bibliotheque.MODIFIE;}
  set setEtatMetier(int etatMetier) => this.etatMetier = etatMetier;
  void setParolesMorceau(String parolesMorceau){this.parolesMorceau = parolesMorceau;}
  void setArtiste(Artiste artiste){this.artiste = artiste;this.codeArtisteMorceau = artiste.getCodeArtiste;etatMetier = Bibliotheque.MODIFIE;  }
  void setAlbum(Album album){this.album = album;}
  void setPlaylistMorceau(List<Playlist> playlist){this.playlistsMorceau = playlist;}

  ////////////////////////////////
  /// AJOUTER RETIRER PRESENCE ///
  ////////////////////////////////

  void ajoutPlaylistMorceau(Playlist p) {
    playlistsMorceau.add(p);
    setEtatMetier = Bibliotheque.MODIFIE;
  }

  bool presencePlaylistMorceau(Playlist p) {
    return genresMorceau.contains(p);
  }

  void retirerPlaylistMorceau(Playlist p) {
    // TODO A COMPLETER
    playlistsMorceau.remove(p);
    setEtatMetier = Bibliotheque.MODIFIE;

  }

  void ajoutGenreMorceau(Genre g) {
    genresMorceau.add(g);
  }

  bool presenceGenreMorceau(Genre g) {
    return genresMorceau.contains(g);
  }

  void retirerGenreMorceau(Genre g) {
    genresMorceau.remove(g);
  }

  ///////////////////////
  // EQUALS & TOSTRING //
  ///////////////////////

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Morceau &&
        o.codeMorceau == codeMorceau &&
        o.titreMorceau == titreMorceau &&
        o.getAlbumMorceau == getAlbumMorceau &&
        o.getArtisteMorceau == getArtisteMorceau &&
        o.cheminMorceau == cheminMorceau &&
        o.anneeMorceau == anneeMorceau &&
        o.parolesMorceau == parolesMorceau &&
        o.auteurCompositeurMorceau == auteurCompositeurMorceau &&
        o.commentaireMorceau == commentaireMorceau &&
        o.etatMetier == etatMetier;
  }

  @override
  int get hashCode {
    return codeMorceau.hashCode ^
        titreMorceau.hashCode ^
        getAlbumMorceau.hashCode ^
        getArtisteMorceau.hashCode ^
        cheminMorceau.hashCode ^
        anneeMorceau.hashCode ^
        parolesMorceau.hashCode ^
        auteurCompositeurMorceau.hashCode ^
        commentaireMorceau.hashCode ^
        etatMetier.hashCode;
  }

  


  @override
  String toString() {
    return 'Morceau(codeMorceau: $codeMorceau, titreMorceau: $titreMorceau, artisteMorceau: $getArtisteMorceau, albumMorceau: $getAlbumMorceau, genresMorceau: $genresMorceau, playlistsMorceau: $playlistsMorceau, cheminMorceau: $cheminMorceau, anneeMorceau: $anneeMorceau, parolesMorceau: $parolesMorceau, auteurCompositeurMorceau: $auteurCompositeurMorceau, commentaireMorceau: $commentaireMorceau, etatMetier: $etatMetier)';
  }
  String toLabel() {
    return this.titreMorceau+"\nPar " +this.artiste.getNomArtiste+" - "+this.album.getTitreAlbum+"\n";
  }

}

@GenBean()
class MorceauBean extends Bean<Morceau> with _MorceauBean{
  final BeanRepo beanRepo;

  MorceauBean(Adapter adapter, this.beanRepo) : super(adapter);

  String get tableName => 'morceau';

}