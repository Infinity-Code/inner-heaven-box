include:
  - eden-system
pkg:
  pkg.latest:
    - require:
      - sls: eden-system

update-pkg:
  cmd.run:
  - name: sudo pkg update -f
  - prereq:
    - pkg: pkg

libgit2:
  pkg.latest:
    - require:
      - pkg: pkg
elixir:
  pkg.latest:
    - require:
      - pkg: pkg
ruby:
  pkg.latest:
    - require:
      - pkg: pkg
rubygem-bundler:
  pkg.latest:
    - require:
      - pkg: pkg
rust:
  pkg.latest:
    - require:
      - pkg: pkg
cargo:
  pkg.latest:
    - require:
      - pkg: pkg
clang36:
  pkg.latest:
    - require:
      - pkg: pkg
