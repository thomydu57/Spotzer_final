
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'genre.dart';
import 'morceau.dart';

part 'detenir.jorm.dart';

class Detenir{


  @BelongsTo.many(GenreBean, refCol: 'codeGenre')
  int codeGenre_id;

  @BelongsTo.many(MorceauBean, refCol: 'codeMorceau')
  int codeMorceau_id;

  static String tableName = 'detenir';

  Detenir();
}

@GenBean()
class DetenirBean extends Bean<Detenir> with _DetenirBean{

  final BeanRepo beanRepo;
  DetenirBean(Adapter adapter,this.beanRepo) : super(adapter);


  String get tableName => 'detenir';




}

