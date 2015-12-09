{% set p = salt['pillar.get']('kafka', {}) %}
{% set pc = p.get('config', {}) %}
{% set g = salt['grains.get']('kafka', {}) %}
{% set gc = g.get('config', {}) %}

{%- set heap_initial_size = gc.get('heap_initial_size', pc.get('heap_initial_size', '1G')) %}
{%- set heap_max_size = gc.get('heap_max_size', pc.get('heap_max_size', '1G')) %}


{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set kafka = {} %}
{%- do kafka.update({
  'heap_initial_size' : heap_initial_size,
  'heap_max_size'     : heap_max_size,
  'config_properties' : config_properties,
}) %}
