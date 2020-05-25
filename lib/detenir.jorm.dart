// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detenir.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _DetenirBean implements Bean<Detenir> {
  final codeGenre_id = IntField('code_genre_id');
  final codeMorceau_id = IntField('code_morceau_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codeGenre_id.name: codeGenre_id,
        codeMorceau_id.name: codeMorceau_id,
      };
  Detenir fromMap(Map map) {
    Detenir model = Detenir();
    model.codeGenre_id = adapter.parseValue(map['code_genre_id']);
    model.codeMorceau_id = adapter.parseValue(map['code_morceau_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Detenir model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(codeGenre_id.set(model.codeGenre_id));
      ret.add(codeMorceau_id.set(model.codeMorceau_id));
    } else if (only != null) {
      if (only.contains(codeGenre_id.name))
        ret.add(codeGenre_id.set(model.codeGenre_id));
      if (only.contains(codeMorceau_id.name))
        ret.add(codeMorceau_id.set(model.codeMorceau_id));
    } else /* if (onlyNonNull) */ {
      if (model.codeGenre_id != null) {
        ret.add(codeGenre_id.set(model.codeGenre_id));
      }
      if (model.codeMorceau_id != null) {
        ret.add(codeMorceau_id.set(model.codeMorceau_id));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codeGenre_id.name,
        foreignTable: genreBean.tableName,
        foreignCol: genreBean.codeGenre.name,
        isNullable: false);
    st.addInt(codeMorceau_id.name,
        foreignTable: morceauBean.tableName,
        foreignCol: morceauBean.codeMorceau.name,
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Detenir model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Detenir> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Detenir model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Detenir> models,
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

  Future<void> updateMany(List<Detenir> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<Detenir>> findByGenre(int codeGenre_id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeGenre_id.eq(codeGenre_id));
    return findMany(find);
  }

  Future<List<Detenir>> findByGenreList(List<Genre> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Genre model in models) {
      find.or(this.codeGenre_id.eq(model.codeGenre));
    }
    return findMany(find);
  }

  Future<int> removeByGenre(int codeGenre_id) async {
    final Remove rm = remover.where(this.codeGenre_id.eq(codeGenre_id));
    return await adapter.remove(rm);
  }

  void associateGenre(Detenir child, Genre parent) {
    child.codeGenre_id = parent.codeGenre;
  }

  Future<int> detachGenre(Genre model) async {
    final dels = await findByGenre(model.codeGenre);
    if (dels.isNotEmpty) {
      await removeByGenre(model.codeGenre);
      final exp = Or();
      for (final t in dels) {
        exp.or(morceauBean.codeMorceau.eq(t.codeMorceau_id));
      }
      return await morceauBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Morceau>> fetchByGenre(Genre model) async {
    final pivots = await findByGenre(model.codeGenre);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(morceauBean.codeMorceau.eq(t.codeMorceau_id));
    }
    return await morceauBean.findWhere(exp);
  }

  Future<List<Detenir>> findByMorceau(int codeMorceau_id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeMorceau_id.eq(codeMorceau_id));
    return findMany(find);
  }

  Future<List<Detenir>> findByMorceauList(List<Morceau> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Morceau model in models) {
      find.or(this.codeMorceau_id.eq(model.codeMorceau));
    }
    return findMany(find);
  }

  Future<int> removeByMorceau(int codeMorceau_id) async {
    final Remove rm = remover.where(this.codeMorceau_id.eq(codeMorceau_id));
    return await adapter.remove(rm);
  }

  void associateMorceau(Detenir child, Morceau parent) {
    child.codeMorceau_id = parent.codeMorceau;
  }

  Future<int> detachMorceau(Morceau model) async {
    final dels = await findByMorceau(model.codeMorceau);
    if (dels.isNotEmpty) {
      await removeByMorceau(model.codeMorceau);
      final exp = Or();
      for (final t in dels) {
        exp.or(genreBean.codeGenre.eq(t.codeGenre_id));
      }
      return await genreBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Genre>> fetchByMorceau(Morceau model) async {
    final pivots = await findByMorceau(model.codeMorceau);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(genreBean.codeGenre.eq(t.codeGenre_id));
    }
    return await genreBean.findWhere(exp);
  }

  Future<dynamic> attach(Morceau one, Genre two, {bool upsert = false}) async {
    final ret = Detenir();
    ret.codeMorceau_id = one.codeMorceau;
    ret.codeGenre_id = two.codeGenre;
    if (!upsert) {
      return insert(ret);
    } else {
      return this.upsert(ret);
    }
  }

  BeanRepo beanRepo;
  GenreBean get genreBean => beanRepo[GenreBean];


  MorceauBean get morceauBean => beanRepo[MorceauBean];
}
