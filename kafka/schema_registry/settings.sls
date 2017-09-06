{%- set p  = salt['pillar.get']('schema_registry', {}) %}
{%- set pc = p.get('config', {}) %}
{%- set g  = salt['grains.get']('schema_registry', {}) %}
{%- set gc = g.get('config', {}) %}

{%- set heap_initial_size = gc.get('heap_initial_size', pc.get('heap_initial_size', '512M')) %}
{%- set heap_max_size = gc.get('heap_max_size', pc.get('heap_max_size', '512M')) %}

{%- set restart_on_config_change = pc.get('restart_on_config_change', False) %}

{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set schema_registry = {} %}
{%- do schema_registry.update({
  'heap_initial_size'        : heap_initial_size,
  'heap_max_size'            : heap_max_size,
  'restart_on_config_change' : restart_on_config_change,
  'config_properties'        : config_properties,
}) %}
