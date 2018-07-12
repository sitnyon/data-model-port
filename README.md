# data-model-port
This is the PostGIS data model for management port infrastructure based on QGIS (2.18 LTR)


PostGIS
-------

* [Schema](sql/01_schema.sql)
* [Tables](sql/02_tables.sql)
* [Triggers](sql/03_triggers.sql)
* [Views](sql/04_views.sql)
* [Rules](sql/05_rules.sql)

Notes : Grants are deliberately exclued. Thinks also to adapt your SRID into tables with geometry.


QGIS
-------

* [Project](qgs/port.qgs)
* [Symbols](qgs/symbols/)

Notes : Make sure to change versions and connection informations before reusing it.

Documentation
-------------

* [User guide](doc/Port.pdf)
