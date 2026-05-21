import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

final Uri _rulesUrl = Uri.parse(
  'https://github.com/dart-lang/sdk/tree-commit-info/main/pkg/linter/lib/src/rules',
);
final Uri _pubRulesUrl = Uri.parse(
  'https://github.com/dart-lang/sdk/tree-commit-info/main/pkg/linter/lib/src/rules/pub',
);

final String _allRulesYaml = path.join('lib', 'all_rules.yaml');
final _dateFormat = DateFormat('dd/MM/yyyy');

/// Script used to update `lib/all_rules.yaml`
///
/// https://github.com/dart-lang/sdk/commit/17a1b9999108c9cfb2c5b0cd227d3392acc8adeb
Future<void> main() async {
  stdout.writeln('Updating all_rules.yaml');
  final (Iterable<String>, Iterable<String>) rules = await (_pullUrl(_rulesUrl), _pullUrl(_pubRulesUrl)).wait;

  final List<String> allRules = [...rules.$1, ...rules.$2].sortedBy((e) => e);
  if (allRules.isEmpty) {
    stderr.writeln('Failed to retrieve latest rules');
    exit(0);
  }

  stdout
    ..writeln('Got latest rules')
    ..writeln('Regenerating lib/all_rules.yaml');

  final buffer = StringBuffer('# Auto-generated options enabling all lints from $_rulesUrl and $_pubRulesUrl')
    ..writeln();
  final String now = _dateFormat.format(DateTime.now());
  buffer
    ..writeln('# Last check: $now (DD/MM/YYYY)')
    ..writeln('linter:')
    ..writeln('  rules:');
  for (final rule in allRules) {
    buffer.writeln('    - $rule');
  }

  final rulesFile = File(_allRulesYaml);
  await rulesFile.writeAsString(buffer.toString());

  stdout.writeln('Done');
}

Future<Iterable<String>> _pullUrl(Uri uri) async {
  try {
    final http.Response(:String body) = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );
    final Map<String, dynamic> json = await Isolate.run(
      () => jsonDecode(body) as Map<String, dynamic>,
    );

    return json.keys
        .map((e) => e.replaceAll('.dart', ''))
        // needs renaming
        .map((e) => e.replaceAll('remove_deprecations_in_breaking_version', 'remove_deprecations_in_breaking_versions'))
        .where(
          (e) => switch (e) {
            'analyzer_element_model_tracking' ||
            'analyzer_public_api' ||
            'pub' ||
            // deprecated
            'always_require_non_null_named_parameters' ||
            'avoid_null_checks_in_equality_operators' ||
            'avoid_as' ||
            'avoid_returning_null_for_future' ||
            'avoid_returning_null' ||
            'avoid_unstable_final_fields' ||
            'enable_null_safety' ||
            'invariant_booleans' ||
            'iterable_contains_unrelated_type' ||
            'list_remove_unrelated_type' ||
            'package_api_docs' ||
            'prefer_bool_in_asserts' ||
            'prefer_equal_for_default_values' ||
            'prefer_final_parameters' ||
            'super_goes_last' ||
            'unsafe_html' ||
            'use_if_null_to_convert_nulls_to_bools' => false,
            _ => true,
          },
        );
  } on Exception catch (e) {
    stderr.writeln('Failed to get $uri ($e)');

    return {};
  }
}
