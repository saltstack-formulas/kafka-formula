{% set p = salt['pillar.get']('kafka', {}) %}
{% set pc = p.get('config', {}) %}
{% set g = salt['grains.get']('kafka', {}) %}
{% set gc = g.get('config', {}) %}

{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set kafka = {} %}
{%- do kafka.update({
  'config_properties' : config_properties,
}) %}
