import 'package:jaguar_orm/jaguar_orm.dart';

import 'bibliotheque.dart';
import 'morceau.dart';

part 'album.jorm.dart';

class Album {
  ////////////////
  //// FIELDS ////
  ////////////////

  @PrimaryKey(isNullable: false)
  int codeAlbum;

  @Column(length: 30, isNullable: true)
  String titreAlbum;

  @HasMany(MorceauBean)
  List<Morceau> morceauxAlbum;

  @Column(isNullable: true)
  int anneeAlbum;

  @IgnoreColumn()
  int etatMetier;


  static const tableName = 'artiste';

  

  //////////////////////
  //// CONSTRUCTORS ////
  //////////////////////

  Album(String titreAlbum, int anneeAlbum, int codeAlbum) {
    this.codeAlbum = codeAlbum;
    morceauxAlbum = new List<Morceau>();
		this.titreAlbum = titreAlbum;
		this.anneeAlbum = anneeAlbum;
    etatMetier = Bibliotheque.CREE;
  }

  Album.vide() {
    etatMetier = Bibliotheque.CREE;
  }

  /////////////////
  //// GETTERS ////
  /////////////////

  int get getCodeAbum => codeAlbum;
  String get getTitreAlbum => titreAlbum;
  List<Morceau> get getMorceauxAlbum => morceauxAlbum;
  int get getAnneeAlbum => anneeAlbum;
  int get getEtatMetier => etatMetier;

  //////////////////
  //// SETTERS ////
  ////////////////

  set setCodeAlbum(int code) => codeAlbum = code;
  void setTitreAlbum(String titre) {titreAlbum = titre; etatMetier = Bibliotheque.MODIFIE;}
  void setMorceauxAlbum(List<Morceau> morceauxAlbum) {this.morceauxAlbum = morceauxAlbum; etatMetier = Bibliotheque.MODIFIE;}
  void setAnneeAlbum(int annee) {anneeAlbum = annee; etatMetier = Bibliotheque.MODIFIE;}
  set setEtatMetier(int etatMetier) => this.etatMetier = etatMetier;

  ////////////////////////////////
  /// AJOUTER RETIRER PRESENCE ///
  ////////////////////////////////

  void ajoutMorceauAlbum(Morceau m) {
    morceauxAlbum.add(m);
  }

  void retirerMorceauAlbum(Morceau m) {
    morceauxAlbum.remove(m);
  }

  bool presenceMorceauAlbum(Morceau m) {
    return morceauxAlbum.contains(m);
  }

  ///////////////////////
  // EQUALS & TOSTRING //
  ///////////////////////

  @override
  String toString() {
    return 'Album(codeAlbum: $codeAlbum, titreAlbum: $titreAlbum, anneeAlbum: $anneeAlbum, etatMetier: $etatMetier)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Album &&
        o.codeAlbum == codeAlbum &&
        o.titreAlbum == titreAlbum &&
        o.anneeAlbum == anneeAlbum &&
        o.etatMetier == etatMetier;
  }


  bool equalsSansCode(Object o) {
    if (identical(this, o)) return true;

    return o is Album &&
        o.titreAlbum == titreAlbum &&
        o.anneeAlbum == anneeAlbum &&
        o.etatMetier == etatMetier;
  }

  @override
  int get hashCode {
    return codeAlbum.hashCode ^
        titreAlbum.hashCode ^
        anneeAlbum.hashCode ^
        etatMetier.hashCode;
  }
}


@GenBean()
class AlbumBean extends Bean<Album> with _AlbumBean {
  
  final BeanRepo beanRepo;

  AlbumBean(Adapter adapter, this.beanRepo) : super(adapter);

  String get tableName => 'album';


}
