import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

void main() {
  updateLocalizationFile();
}

Future<void> updateLocalizationFile() async {
  //the document id for your google sheet
  const String documentId = '1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk';
  //the sheetid of your google sheet
  const String sheetId = '0';

  String _phraseKey = '';
  final List<LocalizationModel> _localizations = <LocalizationModel>[];
  String _localizationFile = """import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    """;

  try {
    const String url =
        'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Downloading Google sheet url "$url" ...');
    stdout.writeln('---------------------------------------');
    final http.Response response = await http
        .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

    // print('Google sheet csv:\n ${response.body}');

    final List<int> bytes = response.bodyBytes.toList();
    final Stream<List<int>> csv = Stream<List<int>>.fromIterable([bytes]);

    final List<List<dynamic>> fields = await csv
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();

    final List<String> index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((String x) => x.isNotEmpty)
        .toList();

    for (int r = 1; r < fields.length; r++) {
      final List<dynamic> rowValues = fields[r];

      /// Creating a map
      final Map<String, String> row = Map<String, String>.fromEntries(
        rowValues
            .asMap()
            .entries
            .where(
              (e) => e.key < index.length,
            )
            .map(
              (MapEntry<int, dynamic> e) => MapEntry(index[e.key], e.value),
            ),
      );

      row.forEach((String key, String value) {
        if (key == 'key') {
          _phraseKey = value;
        } else {
          bool _languageAdded = false;
          for (final LocalizationModel element in _localizations) {
            if (element.language == key) {
              element.phrases.add(PhraseModel(key: _phraseKey, phrase: value));
              _languageAdded = true;
            }
          }
          if (_languageAdded == false) {
            _localizations.add(LocalizationModel(
                language: key,
                phrases: [PhraseModel(key: _phraseKey, phrase: value)]));
          }
        }
      });
    }

    for (final LocalizationModel _localization in _localizations) {
      final String _language = _localization.language;
      final String _currentLanguageTextCode = "'$_language': {\n";
      _localizationFile = _localizationFile + _currentLanguageTextCode;
      for (final PhraseModel _phrase in _localization.phrases) {
        final String _phraseKey = _phrase.key;
        final String _phrasePhrase = _phrase.phrase.replaceAll(r"'", "\\\'");
        final String _currentPhraseTextCode =
            "'$_phraseKey': '$_phrasePhrase',\n";
        _localizationFile = _localizationFile + _currentPhraseTextCode;
      }
      const String _currentLanguageCodeEnding = '},\n';
      _localizationFile = _localizationFile + _currentLanguageCodeEnding;
    }
    const String _fileEnding = '''
        };
      }
      ''';
    _localizationFile = _localizationFile + _fileEnding;

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Saving localization.g.dart');
    stdout.writeln('---------------------------------------');
    final File file = File('localization.g.dart');
    await file.writeAsString(_localizationFile);
    stdout.writeln('Done...');
  } catch (e) {
    //output error
    stderr.writeln('error: networking error');
    stderr.writeln(e.toString());
  }
}

String _uniformizeKey(String key) {
  key = key.trim().replaceAll('\n', '').toLowerCase();
  return key;
}

//Localization Model
class LocalizationModel {
  LocalizationModel({
    required this.language,
    required this.phrases,
  });

  factory LocalizationModel.fromMap(Map<String, dynamic> data) {
    return LocalizationModel(
      language: data['language'],
      phrases:
          (data['phrases'] as List).map((v) => PhraseModel.fromMap(v)).toList(),
    );
  }

  final String language;
  final List<PhraseModel> phrases;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'language': language,
        'phrases':
            List<dynamic>.from(phrases.map((PhraseModel x) => x.toJson())),
      };
}

class PhraseModel {
  PhraseModel({required this.key, required this.phrase});

  factory PhraseModel.fromMap(Map<String, dynamic> data) {
    return PhraseModel(
      key: data['key'],
      phrase: data['phrase'] ?? '',
    );
  }

  String key;
  String phrase;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'phrase': phrase,
      };
}
