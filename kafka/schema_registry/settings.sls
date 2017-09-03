{%- set p  = salt['pillar.get']('schema_registry', {}) %}
{%- set pc = p.get('config', {}) %}
{%- set g  = salt['grains.get']('schema_registry', {}) %}
{%- set gc = g.get('config', {}) %}

{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set schema_registry = {} %}
{%- do schema_registry.update({
  'config_properties': config_properties,
}) %}
