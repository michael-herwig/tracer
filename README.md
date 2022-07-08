# tracer [![License: MIT](https://img.shields.io/github/license/michael-herwig/tracer?style=flat-square)](https://opensource.org/licenses/MIT) [![Codecov](https://codecov.io/gh/michael-herwig/tracer/branch/main/graph/badge.svg?token=VMOAQRNIAQ)](https://codecov.io/gh/michael-herwig/tracer)

### GIT

Suppose you want to use a repository-specific git configuration. In that case,
you can add a new configuration file, `.gituser`, and enable _git_ to include
the repository `.gitconfig` file by running the following command within the
repository directory.

```bash
git config --local include.path ../.gitconfig
```
