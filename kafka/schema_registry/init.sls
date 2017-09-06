{%- from 'zookeeper/settings.sls' import zk with context %}
{%- from 'kafka/schema_registry/settings.sls' import schema_registry with context %}

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

systemd unit file for Schema Registry:
  file.managed:
    - name: /lib/systemd/system/schema-registry.service
    - source: salt://kafka/files/schema-registry.service

Schema Registry environment file:
  file.managed:
    - name: /etc/default/schema-registry
    - source: salt://kafka/files/schema-registry.env
    - template: jinja

start Schema Registry service:
  service.running:
    - name: schema-registry
    - enable: True
  {%- if schema_registry.restart_on_config_change == True %}
    - watch:
      - file: configure Schema Registry
      - file: Schema Registry environment file
  {%- endif %}
