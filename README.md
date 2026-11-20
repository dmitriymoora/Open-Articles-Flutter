# Открытые статьи (Flutter)

Каталог научных статей открытого доступа. Приложение показывает список статей, поиск, карточку детали, связанные материалы, переключение темы и языка.

**Источник данных:** [DOAJ](https://doaj.org) API (`https://doaj.org/api`).  
**Курс:** «Кроссплатформенная разработка», группа ПИН-252т.  
**Ветка:** `feature/lab-3_network` — сеть вместо моков (ЛР3).

## Запуск

```bash
flutter pub get
flutter run -d chrome
flutter run -d windows
```

После правки DTO:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Проверка ARB:

```bash
dart run tool/check_arb.dart
```

## Сеть

Цепочка: `Dio` → `ArticleApi` → `NetworkArticleDataSource` → `ArticleRepository` → Cubit/Bloc → экран.

У DOAJ есть CORS, поэтому работает и в браузере.

## Структура

```
lib/
  app.dart, main.dart
  common/        navigation, theme, settings, network (Dio, LoadException), widgets
  features/article/
    data/          api/, dto/, data_sources/, mappers/, repository
    domain/        ArticleModel, ArticlePage, IArticleRepository
    presentation/  bloc/, view/, utils/
  l10n/
tool/check_arb.dart
```
