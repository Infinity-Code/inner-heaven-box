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
/usr/local/etc/pkg/repos/edenbsd.conf:
  file.managed:
    - user: root
    - group: wheel
    - mode: 644
    - source: salt://salt-edenbsd-repo.conf

/usr/local/etc/pkg/repos/freebsd.conf:
  file.managed:
    - user: root
    - group: wheel
    - mode: 644
    - source: salt://salt-freebsd-repo.conf

/usr/local/etc/ssl/certs/edenbsd.cert:
  file.managed:
    - user: root
    - group: wheel
    - mode: 644
    - source: salt://salt-edenbsd.cert
    - makedirs: True
