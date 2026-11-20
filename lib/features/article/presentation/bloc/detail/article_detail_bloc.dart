import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/network/load_exception.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository) : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onLoad);
    on<ArticleDetailRetried>(_onLoad);
  }

  final IArticleRepository _repository;

  Future<void> _onLoad(
    ArticleDetailEvent event,
    Emitter<ArticleDetailState> emit,
  ) async {
    emit(const ArticleDetailLoading());
    try {
      final article = await _repository.getArticle(event.id);
      List<ArticleModel> related = const [];
      try {
        related = await _repository.getRelated(article);
      } on LoadException {
        related = const [];
      }
      if (emit.isDone) return;
      emit(ArticleDetailLoaded(article: article, related: related));
    } on NotFoundException {
      if (emit.isDone) return;
      emit(ArticleDetailNotFound(event.id));
    } on LoadException catch (error) {
      if (emit.isDone) return;
      emit(ArticleDetailFailure(event.id, error));
    }
  }
}