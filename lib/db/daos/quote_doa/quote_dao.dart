import 'package:drift/drift.dart';
import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/db/tables/quotes.dart';
import 'package:drifttest/db/tables/users.dart';

part 'quote_dao.g.dart';

@DriftAccessor(tables: [Quotes, Users])
class QuotesDao extends DatabaseAccessor<AppDatabase>
    with _$QuotesDaoMixin {
  final AppDatabase db;
  QuotesDao(this.db) : super(db);

  // CRUD --------- METHODS
  Future<List<Quote>> getUsersQuotes(String id) async {
    return await (db.select(quotes)
      ..where((quote) => quote.authorId.equals(id))).get();
  }

  Future<Quote> getSingleQuote(int id) async {
    return await (db.select(quotes)
      ..where((quote) => quote.id.equals(id))).getSingle();
  }

  Future<int> createQuote(Quote quote) async {
    print('Created Quote');
    return await db.into(quotes).insert(quote);
  }

  Future updateQuote(QuotesCompanion quote) async {
    return await db.update(quotes).replace(quote);
  }

  Future<int> deleteQuote(int id) {
    return (db.delete(quotes)
      ..where((quote) => quote.id.equals(id))).go();
  }
}
