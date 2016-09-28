=====
kafka
=====

Formula to set up and configure a single-node Kafka server or multi-node Kafka cluster.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``kafka``
---------

Downloads and install Confluent Platform Kafka Debian packages.

``kafka.server``
----------------

Enables and starts the Kafka service. Only works if 'kafka' is one of the roles (grains) of the node. This separation
allows for nodes to have the Kafka libs and environment available without running the service.
