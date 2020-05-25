// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appartenir.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AppartenirBean implements Bean<Appartenir> {
  final codePlaylist_id = IntField('code_playlist_id');
  final codeMorceau_id = IntField('code_morceau_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        codePlaylist_id.name: codePlaylist_id,
        codeMorceau_id.name: codeMorceau_id,
      };
  Appartenir fromMap(Map map) {
    Appartenir model = Appartenir();
    model.codePlaylist_id = adapter.parseValue(map['code_playlist_id']);
    model.codeMorceau_id = adapter.parseValue(map['code_morceau_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Appartenir model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(codePlaylist_id.set(model.codePlaylist_id));
      ret.add(codeMorceau_id.set(model.codeMorceau_id));
    } else if (only != null) {
      if (only.contains(codePlaylist_id.name))
        ret.add(codePlaylist_id.set(model.codePlaylist_id));
      if (only.contains(codeMorceau_id.name))
        ret.add(codeMorceau_id.set(model.codeMorceau_id));
    } else /* if (onlyNonNull) */ {
      if (model.codePlaylist_id != null) {
        ret.add(codePlaylist_id.set(model.codePlaylist_id));
      }
      if (model.codeMorceau_id != null) {
        ret.add(codeMorceau_id.set(model.codeMorceau_id));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(codePlaylist_id.name,
        foreignTable: playlistBean.tableName,
        foreignCol: playlistBean.codePlaylist.name,
        isNullable: false);
    st.addInt(codeMorceau_id.name,
        foreignTable: morceauBean.tableName,
        foreignCol: morceauBean.codeMorceau.name,
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Appartenir model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Appartenir> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Appartenir model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Appartenir> models,
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

  Future<void> updateMany(List<Appartenir> models,
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

  Future<List<Appartenir>> findByPlaylist(int codePlaylist_id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codePlaylist_id.eq(codePlaylist_id));
    return findMany(find);
  }

  Future<List<Appartenir>> findByPlaylistList(List<Playlist> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Playlist model in models) {
      find.or(this.codePlaylist_id.eq(model.codePlaylist));
    }
    return findMany(find);
  }

  Future<int> removeByPlaylist(int codePlaylist_id) async {
    final Remove rm = remover.where(this.codePlaylist_id.eq(codePlaylist_id));
    return await adapter.remove(rm);
  }

  void associatePlaylist(Appartenir child, Playlist parent) {
    child.codePlaylist_id = parent.codePlaylist;
  }

  Future<int> detachPlaylist(Playlist model) async {
    final dels = await findByPlaylist(model.codePlaylist);
    if (dels.isNotEmpty) {
      await removeByPlaylist(model.codePlaylist);
      final exp = Or();
      for (final t in dels) {
        exp.or(morceauBean.codeMorceau.eq(t.codeMorceau_id));
      }
      return await morceauBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Morceau>> fetchByPlaylist(Playlist model) async {
    final pivots = await findByPlaylist(model.codePlaylist);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(morceauBean.codeMorceau.eq(t.codeMorceau_id));
    }
    return await morceauBean.findWhere(exp);
  }

  Future<List<Appartenir>> findByMorceau(int codeMorceau_id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.codeMorceau_id.eq(codeMorceau_id));
    return findMany(find);
  }

  Future<List<Appartenir>> findByMorceauList(List<Morceau> models,
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

  void associateMorceau(Appartenir child, Morceau parent) {
    child.codeMorceau_id = parent.codeMorceau;
  }

  Future<int> detachMorceau(Morceau model) async {
    final dels = await findByMorceau(model.codeMorceau);
    if (dels.isNotEmpty) {
      await removeByMorceau(model.codeMorceau);
      final exp = Or();
      for (final t in dels) {
        exp.or(playlistBean.codePlaylist.eq(t.codePlaylist_id));
      }
      return await playlistBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Playlist>> fetchByMorceau(Morceau model) async {
    final pivots = await findByMorceau(model.codeMorceau);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(playlistBean.codePlaylist.eq(t.codePlaylist_id));
    }
    return await playlistBean.findWhere(exp);
  }

  Future<dynamic> attach(Playlist one, Morceau two,
      {bool upsert = false}) async {
    final ret = Appartenir();
    ret.codePlaylist_id = one.codePlaylist;
    ret.codeMorceau_id = two.codeMorceau;
    if (!upsert) {
      return insert(ret);
    } else {
      return this.upsert(ret);
    }
  }

  BeanRepo beanRepo;
  MorceauBean get morceauBean => beanRepo[MorceauBean];


  PlaylistBean get playlistBean => beanRepo[PlaylistBean];

}
