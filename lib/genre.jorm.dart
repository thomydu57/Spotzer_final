// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _GenreBean implements Bean<Genre> {
  final codeGenre = IntField('code_genre');
  final libelleGenre = StrField('libelle_genre');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codeGenre.name: codeGenre,
        libelleGenre.name: libelleGenre,
      };
  Genre fromMap(Map map) {
    Genre model = Genre();
    model.codeGenre = adapter.parseValue(map['code_genre']);
    model.libelleGenre = adapter.parseValue(map['libelle_genre']);

    return model;
  }

  List<SetColumn> toSetColumns(Genre model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.codeGenre != null) {
        ret.add(codeGenre.set(model.codeGenre));
      }
      ret.add(libelleGenre.set(model.libelleGenre));
    } else if (only != null) {
      if (model.codeGenre != null) {
        if (only.contains(codeGenre.name))
          ret.add(codeGenre.set(model.codeGenre));
      }
      if (only.contains(libelleGenre.name))
        ret.add(libelleGenre.set(model.libelleGenre));
    } else /* if (onlyNonNull) */ {
      if (model.codeGenre != null) {
        ret.add(codeGenre.set(model.codeGenre));
      }
      if (model.libelleGenre != null) {
        ret.add(libelleGenre.set(model.libelleGenre));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codeGenre.name,
        primary: true, autoIncrement: true, isNullable: false);
    st.addStr(libelleGenre.name, length:30, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Genre model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(codeGenre.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Genre newModel;
      if (model.morceauxGenre != null) {
        newModel ??= await find(retId);
        for (final child in model.morceauxGenre) {
          await morceauBean.insert(child, cascade: cascade);
          await detenirBean.attach(child, newModel);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Genre> models,
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

  Future<dynamic> upsert(Genre model,
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
            .where(this.codeGenre.eq(model.codeGenre))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(codeGenre.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Genre newModel;
      if (model.morceauxGenre != null) {
        newModel ??= await find(retId);
        for (final child in model.morceauxGenre) {
          await morceauBean.upsert(child, cascade: cascade);
          await detenirBean.attach(child, newModel, upsert: true);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Genre> models,
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

  Future<int> update(Genre model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.codeGenre.eq(model.codeGenre))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Genre newModel;
      if (model.morceauxGenre != null) {
        for (final child in model.morceauxGenre) {
          await morceauBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Genre> models,
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
        where.add(this.codeGenre.eq(model.codeGenre));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Genre> find(int codeGenre,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeGenre.eq(codeGenre));
    final Genre model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int codeGenre, {bool cascade = false}) async {
    if (cascade) {
      final Genre newModel = await find(codeGenre);
      if (newModel != null) {
        await detenirBean.detachGenre(newModel);
      }
    }
    final Remove remove = remover.where(this.codeGenre.eq(codeGenre));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Genre> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.codeGenre.eq(model.codeGenre));
    }
    return adapter.remove(remove);
  }

  Future<Genre> preload(Genre model, {bool cascade = false}) async {
    model.morceauxGenre = await detenirBean.fetchByGenre(model);
    return model;
  }

  Future<List<Genre>> preloadAll(List<Genre> models,
      {bool cascade = false}) async {
    for (Genre model in models) {
      var temp = await detenirBean.fetchByGenre(model);
      if (model.morceauxGenre == null)
        model.morceauxGenre = temp;
      else {
        model.morceauxGenre.clear();
        model.morceauxGenre.addAll(temp);
      }
    }
    return models;
  }

  BeanRepo beanRepo;
  DetenirBean get detenirBean => beanRepo[DetenirBean];


  MorceauBean get morceauBean => beanRepo[MorceauBean];
}
