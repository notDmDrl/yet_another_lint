# Yet Another Lint

[![Common Changelog](https://common-changelog.org/badge.svg)](https://common-changelog.org)

_Yet another_ lint rules package with a set of Dart and Flutter linter rules and analyzer setup.
It's incredibly strict, with only around 10 to 15 rules disabled out of +-230, depending on the chosen set.

`yet_another_lint` provides 2 different sets of rules:

-   `defaults` - strict production-ready rule set. Uses 120 chars page width.
-   `package` - based on the `defaults` rule set with 4 additional rules, that make sense for package development, enabled. Uses 80 chars page width.

> [!IMPORTANT]  
> The package's minimum Dart version is set to the version used by the latest Flutter Beta version.
>
> For version **1.0.7** minimum Dart version is **3.8.0**

## Enabling the lints

Add `yet_another_lint` as a dev dependency to your `pubspec.yaml`

```yaml
dev_dependencies:
  yet_another_lint:
    git: https://github.com/notDmDrl/yet_another_lint.git
```

Create an `analysis_options.yaml` file in the root of your project with the following content:

```yaml
# For production apps
include: package:yet_another_lint/defaults.yaml
```

or

```yaml
# For packages with public API
include: package:yet_another_lint/package.yaml
```

depending on your chosen rule set.

### Customizing the selected lint rule set.

For details on customizing static analysis beyond the predefined lint sets, see [Customizing static analysis](https://dart.dev/tools/analysis).

---

> [!NOTE]
> This is a highly opinionated package created for the author's specific needs with no current intention for a public release via [pub.dev](https://pub.dev/).
> The only reason for the public repo is to be able to use the package outside my PC (ex. for work purposes).
