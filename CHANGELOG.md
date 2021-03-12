# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

* GitHub Actions now downloads reference data for tests

### Changed

* uses latest version of MoST, which requires manual installation of Modelica Standard Library

### Fixed

* variable filter annotation was called `varFilter` instead of `variableFilter` in examples

## [1.1.1] - 2021-03-05

### Added

* Zenodo badge in `README.md`

### Changed

[nothing]

### Fixed

* increased simulation time for `PVCNoSinus` to 55 seconds to be able to produce full plot for manuscript
* removed spurious newlines in `RELEASE_HEAD.md`
* fixed artifact name in release script

## [1.1.0] - 2021-03-05

### Added

[nothing]

### Changed

* uses [MoST](https://github.com/THM-MoTE/ModelicaScriptingTools.jl) for test script
* renamed default branch from `master` to `main`
* switched from Travis CI to GitHub Actions
* updated information about publication

### Fixed

[nothing]

## [1.0.0]

### Added

* full modular and monolithic models

### Changed

[nothing]

### Fixed

[nothing]
