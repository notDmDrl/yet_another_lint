# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Common Changelog](https://common-changelog.org/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0-rc.1.html).

## 1.0.7

##### 2025-05-23

### Changed

- Enable `switch_on_type` rule for `defaults.yaml` and `package.yaml` configs.
- Enable `unnecessary_unawaited` rule for `defaults.yaml` and `package.yaml` configs.

## 1.0.6

##### 2025-04-15

### Changed

- Enable `trailing_commas:preserve` in `formatter` settings for `defaults.yaml` and `package.yaml` configs.

## 1.0.5

##### 2025-03-19

### Changed

- Enable `use_null_aware_elements` rule for `defaults.yaml` and `package.yaml` configs.

## 1.0.4

##### 2025-02-13

### Changed

- Disable `require_trailing_commas` rule for `defaults.yaml` and `package.yaml` configs.
- Enable `unnecessary_ignore` rule for `defaults.yaml` and `package.yaml` configs.

## 1.0.3

##### 2025-01-09

### Changed

- Disable `one_member_abstracts` rule for `defaults.yaml` and `package.yaml` configs.
- Enable `unnecessary_underscores` and `unnecessary_async` rules for `defaults.yaml` and `package.yaml` configs.

## 1.0.2

##### 2024-12-30

### Changed

- Disable `type_annotate_public_apis` rule for `defaults.yaml` config.
- Enable `type_annotate_public_apis` rule for `package.yaml` config.

## 1.0.1

##### 2024-12-20

### Fixed

- Fix an issue with all rules being active at the same time ignoring any setup in `defaults.yaml` or `package.yaml`.

## 1.0.0

##### 2024-12-20

_Initial Release._

### Added

-   Add `defaults.yaml` app-specific rule set file.
-   Add `package.yaml` package-specific rule set file.