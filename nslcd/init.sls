{% from "nslcd/map.jinja" import nslcd_settings as nslcd with context %}

nslcd_package:
  pkg.installed:
    - name: {{ nslcd.package_name }}

nslcd_conf:
  file.managed:
    - name: {{ nslcd.conf_path }}
    - user: {{ nslcd.conf_user }}
    - group: {{ nslcd.conf_group }}
    - mode: {{ nslcd.conf_mode }}
    - template: jinja
    - source: salt://nslcd/files/nslcd.conf.jinja
    - require:
      - pkg: nslcd_package

nslcd_service:
  service.running:
    - name: {{ nslcd.service_name }}
    - enable: {{ nslcd.service_enable }}
    - watch:
      - pkg: nslcd_package
      - file: nslcd_conf
