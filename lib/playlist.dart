import 'package:jaguar_orm/jaguar_orm.dart';

import 'appartenir.dart';
import 'bibliotheque.dart';
import 'morceau.dart';

part 'playlist.jorm.dart';

class Playlist {
  ////////////////
  //// FIELDS ////
  ////////////////

  @PrimaryKey(auto: true, isNullable: false)
  int codePlaylist;

  //  Utilisateur createurPlaylist;
  //  int tempsPlaylist;

  @ManyToMany(AppartenirBean,MorceauBean)
  List<Morceau> morceauxPlaylist;

  @Column(length: 25)
  String titrePlaylist;

  @Column(length: 100)
  String descriptionPlaylist;

  @IgnoreColumn()
  int etatMetier;

  //////////////////////
  //// CONSTRUCTORS ////
  //////////////////////

  Playlist.vide() {
    codePlaylist = -1;
    etatMetier = Bibliotheque.CREE;
  }

  Playlist(/* Utilisateur createurPlaylist, */ String titrePlaylist, String descriptionPlaylist) {
		codePlaylist = -1;
		// this.createurPlaylist = createurPlaylist;
		this.titrePlaylist = titrePlaylist;
		this.descriptionPlaylist = descriptionPlaylist;
		etatMetier = Bibliotheque.CREE;
    morceauxPlaylist= new List<Morceau>();
  }
  /////////////////
  //// GETTERS ////
  /////////////////

  int get getCodePlaylist => codePlaylist;
  List<Morceau> get getMorceauxPlaylist => morceauxPlaylist;
  String get getTitrePlaylist => titrePlaylist;
  String get getDescriptionPlaylist => descriptionPlaylist;
  int get getEtatMetier => etatMetier;

  //////////////////
  //// SETTERS ////
  ////////////////

  set setCodePlaylist(int code) => codePlaylist = code;
  void setTitrePlaylist(String titre){titrePlaylist = titre; etatMetier = Bibliotheque.MODIFIE;}
  void setDescriptionPlaylist(String description){descriptionPlaylist = descriptionPlaylist; etatMetier = Bibliotheque.MODIFIE;}
  void setMorceauxPlaylist(List<Morceau> morceauPlaylist){morceauxPlaylist = morceauPlaylist; etatMetier = Bibliotheque.MODIFIE;}
  set setEtatMetier(int etatMetier) => this.etatMetier = etatMetier;


  ////////////////////////////////
  /// AJOUTER RETIRER PRESENCE ///
  ////////////////////////////////

  void ajoutMorceauPlaylist(Morceau m) {
    morceauxPlaylist.add(m);
    etatMetier = Bibliotheque.MODIFIE;
  }

  bool presenceMorceauPlaylist(Morceau m) {
    return morceauxPlaylist.contains(m);
  }

  void retirerMorceauPlaylist(Morceau m) {
    morceauxPlaylist.remove(m);
    etatMetier = Bibliotheque.MODIFIE;
  }

  ///////////////////////
  // EQUALS & TOSTRING //
  ///////////////////////

  @override
  String toString() {
    return 'Playlist(codePlaylist: $codePlaylist, titrePlaylist: $titrePlaylist, descriptionPlaylist: $descriptionPlaylist, etatMetier: $etatMetier)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Playlist &&
        o.codePlaylist == codePlaylist &&
        o.titrePlaylist == titrePlaylist &&
        o.descriptionPlaylist == descriptionPlaylist &&
        o.etatMetier == etatMetier;
  }

  @override
  int get hashCode {
    return codePlaylist.hashCode ^
        titrePlaylist.hashCode ^
        descriptionPlaylist.hashCode ^
        etatMetier.hashCode;
  }
}


@GenBean()
class PlaylistBean extends Bean<Playlist> with _PlaylistBean {
  final BeanRepo beanRepo;
  
  PlaylistBean(Adapter adapter, this.beanRepo) : super(adapter);

  String get tableName => 'playlist';

  

}

