// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PlaylistBean implements Bean<Playlist> {
  final codePlaylist = IntField('code_playlist');
  final titrePlaylist = StrField('titre_playlist');
  final descriptionPlaylist = StrField('description_playlist');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codePlaylist.name: codePlaylist,
        titrePlaylist.name: titrePlaylist,
        descriptionPlaylist.name: descriptionPlaylist,
      };
  Playlist fromMap(Map map) {
    Playlist model = Playlist.vide();
    model.codePlaylist = adapter.parseValue(map['code_playlist']);
    model.titrePlaylist = adapter.parseValue(map['titre_playlist']);
    model.descriptionPlaylist = adapter.parseValue(map['description_playlist']);

    return model;
  }

  List<SetColumn> toSetColumns(Playlist model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.codePlaylist != null) {
        ret.add(codePlaylist.set(model.codePlaylist));
      }
      ret.add(titrePlaylist.set(model.titrePlaylist));
      ret.add(descriptionPlaylist.set(model.descriptionPlaylist));
    } else if (only != null) {
      if (model.codePlaylist != null) {
        if (only.contains(codePlaylist.name))
          ret.add(codePlaylist.set(model.codePlaylist));
      }
      if (only.contains(titrePlaylist.name))
        ret.add(titrePlaylist.set(model.titrePlaylist));
      if (only.contains(descriptionPlaylist.name))
        ret.add(descriptionPlaylist.set(model.descriptionPlaylist));
    } else /* if (onlyNonNull) */ {
      if (model.codePlaylist != null) {
        ret.add(codePlaylist.set(model.codePlaylist));
      }
      if (model.titrePlaylist != null) {
        ret.add(titrePlaylist.set(model.titrePlaylist));
      }
      if (model.descriptionPlaylist != null) {
        ret.add(descriptionPlaylist.set(model.descriptionPlaylist));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codePlaylist.name,
        primary: true, autoIncrement: true, isNullable: false);
    st.addStr(titrePlaylist.name, length: 25, isNullable: false);
    st.addStr(descriptionPlaylist.name, length: 100, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Playlist model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(codePlaylist.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Playlist newModel;
      if (model.morceauxPlaylist != null) {
        newModel ??= await find(retId);
        for (final child in model.morceauxPlaylist) {
          await morceauBean.insert(child, cascade: cascade);
          await appartenirBean.attach(newModel, child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Playlist> models,
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

  Future<dynamic> upsert(Playlist model,
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
            .where(this.codePlaylist.eq(model.codePlaylist))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(codePlaylist.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Playlist newModel;
      if (model.morceauxPlaylist != null) {
        newModel ??= await find(retId);
        for (final child in model.morceauxPlaylist) {
          await morceauBean.upsert(child, cascade: cascade);
          await appartenirBean.attach(newModel, child, upsert: true);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Playlist> models,
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

  Future<int> update(Playlist model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.codePlaylist.eq(model.codePlaylist))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Playlist newModel;
      if (model.morceauxPlaylist != null) {
        for (final child in model.morceauxPlaylist) {
          await morceauBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Playlist> models,
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
        where.add(this.codePlaylist.eq(model.codePlaylist));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Playlist> find(int codePlaylist,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codePlaylist.eq(codePlaylist));
    final Playlist model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int codePlaylist, {bool cascade = false}) async {
    if (cascade) {
      final Playlist newModel = await find(codePlaylist);
      if (newModel != null) {
        await appartenirBean.detachPlaylist(newModel);
      }
    }
    final Remove remove = remover.where(this.codePlaylist.eq(codePlaylist));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Playlist> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.codePlaylist.eq(model.codePlaylist));
    }
    return adapter.remove(remove);
  }

  Future<Playlist> preload(Playlist model, {bool cascade = false}) async {
    model.morceauxPlaylist = await appartenirBean.fetchByPlaylist(model);
    return model;
  }

  Future<List<Playlist>> preloadAll(List<Playlist> models,
      {bool cascade = false}) async {
    for (Playlist model in models) {
      var temp = await appartenirBean.fetchByPlaylist(model);
      if (model.morceauxPlaylist == null)
        model.morceauxPlaylist = temp;
      else {
        model.morceauxPlaylist.clear();
        model.morceauxPlaylist.addAll(temp);
      }
    }
    return models;
  }

  BeanRepo get beanRepo;
  AppartenirBean get appartenirBean => beanRepo[AppartenirBean];

  MorceauBean get morceauBean => beanRepo[MorceauBean];
}
