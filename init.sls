{%- from 'zookeeper/settings.sls' import zk with context %}

kafka-pkg-setup:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://packages.confluent.io/deb/3.0 stable main
    - file: /etc/apt/sources.list.d/kafka.list
    - key_url: http://packages.confluent.io/deb/3.0/archive.key
    - require_in:
      - pkg: confluent-kafka-2.11

  pkg.installed:
    - name: confluent-kafka-2.11
    - refresh: True

kafka-user:
  user.present:
    - name: kafka
    - shell: /bin/false
    - gid_from_name: True
    - createhome: False
    - system: True

/var/log/kafka:
  file.directory:
    - user: kafka
    - group: kafka

kafka-systemd-unit:
  file.managed:
    - name: /lib/systemd/system/kafka.service
    - source: salt://kafka/files/kafka.service.systemd

kafka-config:
  file.managed:
    - name: /etc/kafka/server.properties
    - source: salt://kafka/files/server.properties
    - template: jinja
    - context:
      zookeepers: {{ zk.connection_string }}
    - require:
      - pkg: confluent-kafka-2.11

kafka-environment:
  file.managed:
    - name: /etc/default/kafka
    - source: salt://kafka/files/kafka.default
    - template: jinja

kafka-service:
  service.running:
    - name: kafka
    - enable: True
    - require:
      - pkg: confluent-kafka-2.11
      - file: kafka-config
      - file: kafka-environment
      - file: kafka-systemd-unit
