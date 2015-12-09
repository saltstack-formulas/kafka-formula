{%- from 'zookeeper/settings.sls' import zk with context %}

kafka-pkg-setup:
  pkgrepo.managed:
    - name: deb http://apt.wikimedia.org/wikimedia jessie-wikimedia main
    - file: /etc/apt/sources.list.d/wikimedia.list
    - key_url: http://apt.wikimedia.org/autoinstall/keyring/wikimedia-archive-keyring.gpg
    - require_in:
      - pkg: kafka-server

  pkg.installed:
    - name: kafka-server
    - refresh: True

kafka-config:
  file.managed:
    - name: /etc/kafka/server.properties
    - source: salt://kafka/server.properties
    - template: jinja
    - context:
      zookeepers: {{ zk.connection_string }}
    - require:
      - pkg: kafka-server

kafka-service:
  service.running:
    - name: kafka
    - enable: True
    - require:
      - pkg: kafka-server
      - file: kafka-config
