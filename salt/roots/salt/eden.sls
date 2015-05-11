elixir:
  pkg:
    - installed
ruby:
  pkg:
    - installed

rubygem-bundler:
  pkg:
    - installed

default_locale:
  locale.system:
    - name: en_US.UTF-8

/etc/motd:
  file.managed:
    - user: root
    - group: wheel
    - mode: 0644
    - source: salt://salt-motd.template
    - template: jinja
