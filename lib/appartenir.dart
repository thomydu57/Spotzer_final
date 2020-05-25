import 'package:jaguar_orm/jaguar_orm.dart';

import 'morceau.dart';
import 'playlist.dart';
part 'appartenir.jorm.dart';
class Appartenir{


  @BelongsTo.many(PlaylistBean, refCol: 'codePlaylist')
  int codePlaylist_id;

  @BelongsTo.many(MorceauBean, refCol: 'codeMorceau')
  int codeMorceau_id;

  static String tableName = 'appartenir';

  Appartenir();
}

@GenBean()
class AppartenirBean extends Bean<Appartenir> with _AppartenirBean{

  final BeanRepo beanRepo;
  AppartenirBean(Adapter adapter, this.beanRepo) : super(adapter);


  String get tableName => 'appartenir';





  
}
