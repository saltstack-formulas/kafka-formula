{%- from 'zookeeper/settings.sls' import zk with context %}

install Kafka Schema Registry:
  pkg.installed:
    - name: confluent-schema-registry

configure Schema Registry:
  file.managed:
    - name: /etc/schema-registry/schema-registry.properties
    - source: salt://kafka/files/schema-registry.properties
    - template: jinja
    - context:
      zookeepers: {{ zk.connection_string }}
