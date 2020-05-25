import 'dart:collection';

import 'package:jaguar_orm/jaguar_orm.dart';

import 'bibliotheque.dart';
import 'morceau.dart';

part 'artiste.jorm.dart';

class Artiste {
  ////////////////
  //// FIELDS ////
  ////////////////
  
  @PrimaryKey(isNullable: false)
  int codeArtiste;

  @Column(length: 30, isNullable: true)
  String nomArtiste;

  @HasMany(MorceauBean)
  List<Morceau> morceauxArtiste;

  @IgnoreColumn()
  int etatMetier;

  static const tableName = 'artiste';

  //////////////////////
  //// CONSTRUCTORS ////
  //////////////////////

  Artiste(String nomArtiste, int codeArtiste) {
    this.codeArtiste = codeArtiste;
    this.nomArtiste = nomArtiste;
    morceauxArtiste = new List<Morceau>();
    etatMetier = Bibliotheque.CREE;
  }

  Artiste.vide() {
    morceauxArtiste = new List<Morceau>();
    etatMetier = Bibliotheque.CREE;
  }

  /////////////////
  //// GETTERS ////
  /////////////////

  int get getCodeArtiste => codeArtiste;
  String get getNomArtiste => nomArtiste;
  List<Morceau> get getMorceauxArtiste => morceauxArtiste;
  int get getEtatMetier => etatMetier;

  //////////////////
  //// SETTERS ////
  ////////////////

  set setCodeArtiste(int code) => codeArtiste = code;

  void setNomArtiste(String nom) {
    nomArtiste = nom;
    etatMetier = Bibliotheque.MODIFIE;
  }

  void setMorceauxArtiste(List<Morceau> morceauxArtiste) {
    this.morceauxArtiste = morceauxArtiste;
    etatMetier = Bibliotheque.MODIFIE;
  }

  set setEtatMetier( int etatMetier) => this.etatMetier = etatMetier;

  ////////////////////////////////
  /// AJOUTER RETIRER PRESENCE ///
  ////////////////////////////////

  void ajoutMorceauArtiste(Morceau m) {
    morceauxArtiste.add(m);
  }

  void retirerMorceauArtiste(Morceau m) {
    morceauxArtiste.remove(m);
  }

  bool presenceMorceauArtiste(Morceau m) {
    return morceauxArtiste.contains(m);
  }

  ///////////////////////
  // EQUALS & TOSTRING //
  ///////////////////////

  @override
  String toString() =>
      'Artiste(codeArtiste: $codeArtiste, nomArtiste: $nomArtiste, etatMetier: $etatMetier)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Artiste &&
        o.codeArtiste == codeArtiste &&
        o.nomArtiste == nomArtiste &&
        o.etatMetier == etatMetier;
  }

  bool equalsSansCode(Object o) {
    if (identical(this, o)) return true;

    return o is Artiste &&
        o.nomArtiste == nomArtiste &&
        o.etatMetier == etatMetier;
  }

  @override
  int get hashCode =>
      codeArtiste.hashCode ^ nomArtiste.hashCode ^ etatMetier.hashCode;
}


@GenBean()
class ArtisteBean extends Bean<Artiste> with _ArtisteBean {

  final BeanRepo beanRepo;
  ArtisteBean(Adapter adapter, this.beanRepo) : super(adapter);


  @override
  String get tableName => 'artiste';


}
