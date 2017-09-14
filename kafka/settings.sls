{% set p = salt['pillar.get']('kafka', {}) %}
{% set pc = p.get('config', {}) %}
{% set g = salt['grains.get']('kafka', {}) %}
{% set gc = g.get('config', {}) %}

{%- set jvm_opts = p.get('jvm_opts', []) %}

{%- set heap_initial_size = gc.get('heap_initial_size', pc.get('heap_initial_size', '1G')) %}
{%- set heap_max_size = gc.get('heap_max_size', pc.get('heap_max_size', '1G')) %}

{%- set broker_id = gc.get('broker_id', pc.get('broker_id', None)) %}
{%- set chroot_path = gc.get('chroot_path', pc.get('chroot_path', 'kafka')) %}

{%- set restart_on_config_change = pc.get('restart_on_config_change', False) %}

{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set kafka = {} %}
{%- do kafka.update({
  'jvm_opts'                 : jvm_opts,
  'heap_initial_size'        : heap_initial_size,
  'heap_max_size'            : heap_max_size,
  'broker_id'                : broker_id,
  'chroot_path'              : chroot_path,
  'restart_on_config_change' : restart_on_config_change,
  'config_properties'        : config_properties,
}) %}
