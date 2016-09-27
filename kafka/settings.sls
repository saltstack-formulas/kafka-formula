{% set p = salt['pillar.get']('kafka', {}) %}
{% set pc = p.get('config', {}) %}
{% set g = salt['grains.get']('kafka', {}) %}
{% set gc = g.get('config', {}) %}

{%- set heap_initial_size = gc.get('heap_initial_size', pc.get('heap_initial_size', '1G')) %}
{%- set heap_max_size = gc.get('heap_max_size', pc.get('heap_max_size', '1G')) %}

{%- set chroot_path = gc.get('chroot_path', pc.get('chroot_path', 'kafka')) %}

{%- set targeting_method  = g.get('targeting_method', p.get('targeting_method', 'grain')) %}
{%- set hosts_target      = g.get('hosts_target', p.get('hosts_target', 'roles:kafka')) %}

{%- set broker_hosts = salt.mine.get(hosts_target, 'network.get_hostname', targeting_method).values() %}

{%- set brokers_with_ids = {} %}
{%- for i in range(broker_hosts | length()) %}
  {%- do brokers_with_ids.update({ broker_hosts[i] : i }) %}
{%- endfor %}

{%- set broker_id = brokers_with_ids.get(salt.network.get_hostname(), '') %}

{%- set config_properties = gc.get('properties', pc.get('properties', {})) %}

{%- set kafka = {} %}
{%- do kafka.update({
  'heap_initial_size' : heap_initial_size,
  'heap_max_size'     : heap_max_size,
  'chroot_path'       : chroot_path,
  'broker_id'         : broker_id,
  'config_properties' : config_properties,
}) %}
