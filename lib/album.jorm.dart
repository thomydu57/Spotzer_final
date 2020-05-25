// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AlbumBean implements Bean<Album> {
  final codeAlbum = IntField('code_album');
  final titreAlbum = StrField('titre_album');
  final anneeAlbum = IntField('annee_album');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codeAlbum.name: codeAlbum,
        titreAlbum.name: titreAlbum,
        anneeAlbum.name: anneeAlbum,
      };
  Album fromMap(Map map) {
    Album model = Album.vide();
    model.codeAlbum = adapter.parseValue(map['code_album']);
    model.titreAlbum = adapter.parseValue(map['titre_album']);
    model.anneeAlbum = adapter.parseValue(map['annee_album']);

    return model;
  }

  List<SetColumn> toSetColumns(Album model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(codeAlbum.set(model.codeAlbum));
      ret.add(titreAlbum.set(model.titreAlbum));
      ret.add(anneeAlbum.set(model.anneeAlbum));
    } else if (only != null) {
      if (only.contains(codeAlbum.name))
        ret.add(codeAlbum.set(model.codeAlbum));
      if (only.contains(titreAlbum.name))
        ret.add(titreAlbum.set(model.titreAlbum));
      if (only.contains(anneeAlbum.name))
        ret.add(anneeAlbum.set(model.anneeAlbum));
    } else /* if (onlyNonNull) */ {
      if (model.codeAlbum != null) {
        ret.add(codeAlbum.set(model.codeAlbum));
      }
      if (model.titreAlbum != null) {
        ret.add(titreAlbum.set(model.titreAlbum));
      }
      if (model.anneeAlbum != null) {
        ret.add(anneeAlbum.set(model.anneeAlbum));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codeAlbum.name, primary: true, isNullable: false);
    st.addStr(titreAlbum.name, length: 30, isNullable: true);
    st.addInt(anneeAlbum.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Album model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Album newModel;
      if (model.morceauxAlbum != null) {
        newModel ??= await find(model.codeAlbum);
        model.morceauxAlbum
            .forEach((x) => morceauBean.associateAlbum(x, newModel));
        for (final child in model.morceauxAlbum) {
          await morceauBean.insert(child, cascade: cascade);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Album> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = models
          .map((model) =>
              toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(Album model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    var retId;
    if (isForeignKeyEnabled) {
      final Insert insert = Insert(tableName, ignoreIfExist: true)
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.insert(insert);
      if (retId == null) {
        final Update update = updater
            .where(this.codeAlbum.eq(model.codeAlbum))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Album newModel;
      if (model.morceauxAlbum != null) {
        newModel ??= await find(model.codeAlbum);
        model.morceauxAlbum
            .forEach((x) => morceauBean.associateAlbum(x, newModel));
        for (final child in model.morceauxAlbum) {
          await morceauBean.upsert(child, cascade: cascade);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Album> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    if (cascade || isForeignKeyEnabled) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model,
            cascade: cascade, isForeignKeyEnabled: isForeignKeyEnabled));
      }
      await Future.wait(futures);
      return;
    } else {
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
  }

  Future<int> update(Album model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.codeAlbum.eq(model.codeAlbum))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Album newModel;
      if (model.morceauxAlbum != null) {
        if (associate) {
          newModel ??= await find(model.codeAlbum);
          model.morceauxAlbum
              .forEach((x) => morceauBean.associateAlbum(x, newModel));
        }
        for (final child in model.morceauxAlbum) {
          await morceauBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Album> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
        where.add(this.codeAlbum.eq(model.codeAlbum));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Album> find(int codeAlbum,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeAlbum.eq(codeAlbum));
    final Album model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int codeAlbum, {bool cascade = false}) async {
    if (cascade) {
      final Album newModel = await find(codeAlbum);
      if (newModel != null) {
        await morceauBean.removeByAlbum(newModel.codeAlbum);
      }
    }
    final Remove remove = remover.where(this.codeAlbum.eq(codeAlbum));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Album> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.codeAlbum.eq(model.codeAlbum));
    }
    return adapter.remove(remove);
  }

  Future<Album> preload(Album model, {bool cascade = false}) async {
    model.morceauxAlbum = await morceauBean.findByAlbum(model.codeAlbum,
        preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<Album>> preloadAll(List<Album> models,
      {bool cascade = false}) async {
    models.forEach((Album model) => model.morceauxAlbum ??= []);
    await OneToXHelper.preloadAll<Album, Morceau>(
        models,
        (Album model) => [model.codeAlbum],
        morceauBean.findByAlbumList,
        (Morceau model) => [model.codeAlbumMorceau],
        (Album model, Morceau child) =>
            model.morceauxAlbum = List.from(model.morceauxAlbum)..add(child),
        cascade: cascade);
    return models;
  }

  BeanRepo beanRepo;
  MorceauBean get morceauBean => beanRepo[MorceauBean];
}
