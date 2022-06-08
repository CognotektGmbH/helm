# RabbitMQ

Local copy of
the [bitnami/rabbitmq helm chart in v7.7.1](https://github.com/bitnami/charts/tree/2643e7c9ea13724188011f3bbe76733264d9625d/bitnami/rabbitmq)
which has been deleted from the official helm repository.

The [bitnami/common helm chart in v0.9.0](https://github.com/bitnami/charts/tree/2643e7c9ea13724188011f3bbe76733264d9625d/bitnami/rabbitmq)
is a dependency of `bitnami/rabbitmq helm chart in v7.7.1`. It cannot be referenced when installing from a local copy.
The workaround is to copy the `templates` of `common` to `k8s/charts/bitnami/rabbitmq/templates/common` and change all
references `common.` in every .tpl file to `rabbitmq.common.`.