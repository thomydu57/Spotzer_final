// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artiste.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ArtisteBean implements Bean<Artiste> {
  final codeArtiste = IntField('code_artiste');
  final nomArtiste = StrField('nom_artiste');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codeArtiste.name: codeArtiste,
        nomArtiste.name: nomArtiste,
      };
  Artiste fromMap(Map map) {
    Artiste model = Artiste.vide();
    model.codeArtiste = adapter.parseValue(map['code_artiste']);
    model.nomArtiste = adapter.parseValue(map['nom_artiste']);

    return model;
  }

  List<SetColumn> toSetColumns(Artiste model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(codeArtiste.set(model.codeArtiste));
      ret.add(nomArtiste.set(model.nomArtiste));
    } else if (only != null) {
      if (only.contains(codeArtiste.name))
        ret.add(codeArtiste.set(model.codeArtiste));
      if (only.contains(nomArtiste.name))
        ret.add(nomArtiste.set(model.nomArtiste));
    } else /* if (onlyNonNull) */ {
      if (model.codeArtiste != null) {
        ret.add(codeArtiste.set(model.codeArtiste));
      }
      if (model.nomArtiste != null) {
        ret.add(nomArtiste.set(model.nomArtiste));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codeArtiste.name, primary: true, isNullable: false);
    st.addStr(nomArtiste.name, length: 30, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Artiste model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Artiste newModel;
      if (model.morceauxArtiste != null) {
        newModel ??= await find(model.codeArtiste);
        model.morceauxArtiste
            .forEach((x) => morceauBean.associateArtiste(x, newModel));
        for (final child in model.morceauxArtiste) {
          await morceauBean.insert(child, cascade: cascade);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Artiste> models,
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

  Future<dynamic> upsert(Artiste model,
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
            .where(this.codeArtiste.eq(model.codeArtiste))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Artiste newModel;
      if (model.morceauxArtiste != null) {
        newModel ??= await find(model.codeArtiste);
        model.morceauxArtiste
            .forEach((x) => morceauBean.associateArtiste(x, newModel));
        for (final child in model.morceauxArtiste) {
          await morceauBean.upsert(child, cascade: cascade);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Artiste> models,
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

  Future<int> update(Artiste model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.codeArtiste.eq(model.codeArtiste))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Artiste newModel;
      if (model.morceauxArtiste != null) {
        if (associate) {
          newModel ??= await find(model.codeArtiste);
          model.morceauxArtiste
              .forEach((x) => morceauBean.associateArtiste(x, newModel));
        }
        for (final child in model.morceauxArtiste) {
          await morceauBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Artiste> models,
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
        where.add(this.codeArtiste.eq(model.codeArtiste));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Artiste> find(int codeArtiste,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeArtiste.eq(codeArtiste));
    final Artiste model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int codeArtiste, {bool cascade = false}) async {
    if (cascade) {
      final Artiste newModel = await find(codeArtiste);
      if (newModel != null) {
        await morceauBean.removeByArtiste(newModel.codeArtiste);
      }
    }
    final Remove remove = remover.where(this.codeArtiste.eq(codeArtiste));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Artiste> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.codeArtiste.eq(model.codeArtiste));
    }
    return adapter.remove(remove);
  }

  Future<Artiste> preload(Artiste model, {bool cascade = false}) async {
    model.morceauxArtiste = await morceauBean.findByArtiste(model.codeArtiste,
        preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<Artiste>> preloadAll(List<Artiste> models,
      {bool cascade = false}) async {
    models.forEach((Artiste model) => model.morceauxArtiste ??= []);
    await OneToXHelper.preloadAll<Artiste, Morceau>(
        models,
        (Artiste model) => [model.codeArtiste],
        morceauBean.findByArtisteList,
        (Morceau model) => [model.codeArtisteMorceau],
        (Artiste model, Morceau child) => model.morceauxArtiste =
            List.from(model.morceauxArtiste)..add(child),
        cascade: cascade);
    return models;
  }

  
  BeanRepo beanRepo;
  MorceauBean get morceauBean => beanRepo[MorceauBean];
}
