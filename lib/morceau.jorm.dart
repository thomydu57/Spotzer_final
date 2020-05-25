// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morceau.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _MorceauBean implements Bean<Morceau> {
  final codeMorceau = IntField('code_morceau');
  final titreMorceau = StrField('titre_morceau');
  final codeArtisteMorceau = IntField('code_artiste_morceau');
  final codeAlbumMorceau = IntField('code_album_morceau');
  final cheminMorceau = StrField('chemin_morceau');
  final anneeMorceau = IntField('annee_morceau');
  final parolesMorceau = StrField('paroles_morceau');
  final auteurCompositeurMorceau = StrField('auteur_compositeur_morceau');
  final commentaireMorceau = StrField('commentaire_morceau');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codeMorceau.name: codeMorceau,
        titreMorceau.name: titreMorceau,
        codeArtisteMorceau.name: codeArtisteMorceau,
        codeAlbumMorceau.name: codeAlbumMorceau,
        cheminMorceau.name: cheminMorceau,
        anneeMorceau.name: anneeMorceau,
        parolesMorceau.name: parolesMorceau,
        auteurCompositeurMorceau.name: auteurCompositeurMorceau,
        commentaireMorceau.name: commentaireMorceau,
      };
  Morceau fromMap(Map map) {
    Morceau model = Morceau.vide();
    model.codeMorceau = adapter.parseValue(map['code_morceau']);
    model.titreMorceau = adapter.parseValue(map['titre_morceau']);
    model.codeArtisteMorceau = adapter.parseValue(map['code_artiste_morceau']);
    model.codeAlbumMorceau = adapter.parseValue(map['code_album_morceau']);
    model.cheminMorceau = adapter.parseValue(map['chemin_morceau']);
    model.anneeMorceau = adapter.parseValue(map['annee_morceau']);
    model.parolesMorceau = adapter.parseValue(map['paroles_morceau']);
    model.auteurCompositeurMorceau =
        adapter.parseValue(map['auteur_compositeur_morceau']);
    model.commentaireMorceau = adapter.parseValue(map['commentaire_morceau']);

    return model;
  }

  List<SetColumn> toSetColumns(Morceau model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(codeMorceau.set(model.codeMorceau));
      ret.add(titreMorceau.set(model.titreMorceau));
      ret.add(codeArtisteMorceau.set(model.codeArtisteMorceau));
      ret.add(codeAlbumMorceau.set(model.codeAlbumMorceau));
      ret.add(cheminMorceau.set(model.cheminMorceau));
      ret.add(anneeMorceau.set(model.anneeMorceau));
      ret.add(parolesMorceau.set(model.parolesMorceau));
      ret.add(auteurCompositeurMorceau.set(model.auteurCompositeurMorceau));
      ret.add(commentaireMorceau.set(model.commentaireMorceau));
    } else if (only != null) {
      if (only.contains(codeMorceau.name))
        ret.add(codeMorceau.set(model.codeMorceau));
      if (only.contains(titreMorceau.name))
        ret.add(titreMorceau.set(model.titreMorceau));
      if (only.contains(codeArtisteMorceau.name))
        ret.add(codeArtisteMorceau.set(model.codeArtisteMorceau));
      if (only.contains(codeAlbumMorceau.name))
        ret.add(codeAlbumMorceau.set(model.codeAlbumMorceau));
      if (only.contains(cheminMorceau.name))
        ret.add(cheminMorceau.set(model.cheminMorceau));
      if (only.contains(anneeMorceau.name))
        ret.add(anneeMorceau.set(model.anneeMorceau));
      if (only.contains(parolesMorceau.name))
        ret.add(parolesMorceau.set(model.parolesMorceau));
      if (only.contains(auteurCompositeurMorceau.name))
        ret.add(auteurCompositeurMorceau.set(model.auteurCompositeurMorceau));
      if (only.contains(commentaireMorceau.name))
        ret.add(commentaireMorceau.set(model.commentaireMorceau));
    } else /* if (onlyNonNull) */ {
      if (model.codeMorceau != null) {
        ret.add(codeMorceau.set(model.codeMorceau));
      }
      if (model.titreMorceau != null) {
        ret.add(titreMorceau.set(model.titreMorceau));
      }
      if (model.codeArtisteMorceau != null) {
        ret.add(codeArtisteMorceau.set(model.codeArtisteMorceau));
      }
      if (model.codeAlbumMorceau != null) {
        ret.add(codeAlbumMorceau.set(model.codeAlbumMorceau));
      }
      if (model.cheminMorceau != null) {
        ret.add(cheminMorceau.set(model.cheminMorceau));
      }
      if (model.anneeMorceau != null) {
        ret.add(anneeMorceau.set(model.anneeMorceau));
      }
      if (model.parolesMorceau != null) {
        ret.add(parolesMorceau.set(model.parolesMorceau));
      }
      if (model.auteurCompositeurMorceau != null) {
        ret.add(auteurCompositeurMorceau.set(model.auteurCompositeurMorceau));
      }
      if (model.commentaireMorceau != null) {
        ret.add(commentaireMorceau.set(model.commentaireMorceau));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codeMorceau.name, primary: true, isNullable: false);
    st.addStr(titreMorceau.name, length: 30, isNullable: true);
    st.addInt(codeArtisteMorceau.name,
        foreignTable: artisteBean.tableName,
        foreignCol: artisteBean.codeArtiste.name,
        isNullable: true);
    st.addInt(codeAlbumMorceau.name,
        foreignTable: albumBean.tableName,
        foreignCol: albumBean.codeAlbum.name,
        isNullable: true);
    st.addStr(cheminMorceau.name, length: 150, isNullable: false);
    st.addInt(anneeMorceau.name, isNullable: true);
    st.addStr(parolesMorceau.name, length: 1500, isNullable: true);
    st.addStr(auteurCompositeurMorceau.name, length: 100, isNullable: true);
    st.addStr(commentaireMorceau.name, length: 500, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Morceau model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      var albumModel = model.album;
      var artisteModel = model.artiste;
      if (albumModel != null) {
        morceauBean.associateAlbum(model, albumModel);
        var alb = await albumBean.find(albumModel.codeAlbum);
        if (alb == null) {
          await albumBean.insert(albumModel);
        }
      }
      if (artisteModel != null) {
        morceauBean.associateArtiste(model, artisteModel);
        var art = await artisteBean.find(artisteModel.codeArtiste);
        if (art == null) {
          await artisteBean.insert(artisteModel);
        }
      }
      final Insert insert = inserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      var retId = await adapter.insert(insert);
      print(model.titreMorceau);
      print(model.genresMorceau);
      for (final child in model.genresMorceau) {
        //await genreBean.insert(child, cascade: cascade);
        await detenirBean.attach(model, child);
        await genreBean.update(child);
      }
      for (final child in model.playlistsMorceau) {
        var playlist = await playlistBean.find(child.codePlaylist);
        if (playlist == null) {
          await playlistBean.insert(child);
        } else {
          await playlistBean.update(child);
        }
        await appartenirBean.attach(child, model);
      }
      return retId;
    }
    return null;
  }

  Future<void> insertMany(List<Morceau> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Morceau model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Morceau> models,
      {bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Morceau nouveauMorceau,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    if (cascade) {
      var artisteActuel = nouveauMorceau.artiste;
      var ancienMorceau = await morceauBean.find(nouveauMorceau.codeMorceau);
      ancienMorceau
          .setArtiste(await artisteBean.find(ancienMorceau.codeArtisteMorceau));
      ancienMorceau
          .setAlbum(await albumBean.find(ancienMorceau.codeAlbumMorceau));
      if (artisteActuel != null) {
        if (ancienMorceau.codeArtisteMorceau !=
            nouveauMorceau.codeArtisteMorceau) {
          await artisteBean.insert(nouveauMorceau.artiste);
          if (ancienMorceau.artiste.getMorceauxArtiste.length <= 1)
            await artisteBean.remove(ancienMorceau.artiste.codeArtiste);
          else {
            ancienMorceau.artiste.retirerMorceauArtiste(ancienMorceau);
          }
        }
      } else {
        // l'artiste est nul germain nul
      }

      if (nouveauMorceau.genresMorceau != null) {
        for (final child in nouveauMorceau.genresMorceau) {
          await genreBean.update(child, cascade: false, associate: associate);
        }
      }
      if (nouveauMorceau.playlistsMorceau != null) {
        for (final child in nouveauMorceau.playlistsMorceau) {
          await playlistBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    final Update update = updater
        .where(this.codeMorceau.eq(nouveauMorceau.codeMorceau))
        .setMany(
            toSetColumns(nouveauMorceau, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    return ret;
  }

  Future<void> updateMany(List<Morceau> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.codeMorceau.eq(model.codeMorceau));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Morceau> find(int codeMorceau,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeMorceau.eq(codeMorceau));
    return await findOne(find);
  }

  Future<int> remove(int codeMorceau) async {
    final Remove remove = remover.where(this.codeMorceau.eq(codeMorceau));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Morceau> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.codeMorceau.eq(model.codeMorceau));
    }
    return adapter.remove(remove);
  }

  Future<List<Morceau>> findByArtiste(int codeArtisteMorceau,
      {bool preload = false, bool cascade = false}) async {
    final Find find =
        finder.where(this.codeArtisteMorceau.eq(codeArtisteMorceau));
    return findMany(find);
  }

  Future<List<Morceau>> findByArtisteList(List<Artiste> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Artiste model in models) {
      find.or(this.codeArtisteMorceau.eq(model.codeArtiste));
    }
    return findMany(find);
  }

  Future<int> removeByArtiste(int codeArtisteMorceau) async {
    final Remove rm =
        remover.where(this.codeArtisteMorceau.eq(codeArtisteMorceau));
    return await adapter.remove(rm);
  }

  void associateArtiste(Morceau child, Artiste parent) {
    child.codeArtisteMorceau = parent.codeArtiste;
  }

  Future<List<Morceau>> findByAlbum(int codeAlbumMorceau,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeAlbumMorceau.eq(codeAlbumMorceau));
    return findMany(find);
  }

  Future<List<Morceau>> findByAlbumList(List<Album> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Album model in models) {
      find.or(this.codeAlbumMorceau.eq(model.codeAlbum));
    }
    return findMany(find);
  }

  Future<int> removeByAlbum(int codeAlbumMorceau) async {
    final Remove rm = remover.where(this.codeAlbumMorceau.eq(codeAlbumMorceau));
    return await adapter.remove(rm);
  }

  void associateAlbum(Morceau child, Album parent) {
    child.codeAlbumMorceau = parent.codeAlbum;
  }

  BeanRepo get beanRepo;
  ArtisteBean get artisteBean => beanRepo[ArtisteBean];
  MorceauBean get morceauBean => beanRepo[MorceauBean];
  AlbumBean get albumBean => beanRepo[AlbumBean];
  GenreBean get genreBean => beanRepo[GenreBean];
  DetenirBean get detenirBean => beanRepo[DetenirBean];
  PlaylistBean get playlistBean => beanRepo[PlaylistBean];
  AppartenirBean get appartenirBean => beanRepo[AppartenirBean];
}
