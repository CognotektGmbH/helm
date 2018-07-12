# fluentd chart

**WARNING:** This is not stable yet!

## Main purpose

* A simple install-and-work solution for fluentd
* A base container that makes it easy (for us ;) to configure installed fluentd plugins
* Both being easily cloned for your own purposes if you really need to.

## Configuration

Install using `helm install repo/fluentd`.

###  Parameters

| Parameter | Description | Default |
|---------- | ----------- | ------- |
| `replicaCount`                     | How many fluentd containers to launch                 | `2`                              |
| `image.repository`                 |                                                       | `quay.io/c11h/fluentd`           |
| `image.tag`                        |                                                       | `latest`                         |
| `image.pullPolicy`                 |                                                       | `Always`                         |
| `service.type`                     |                                                       | `ClusterIP`                      |
| `config.default`                   |                                                       | See below                        |
| `source.insecureForward.enable`    | Enable the `forward` input in an insecure version     | `true`                           |
| `source.insecureForward.port`      | Which port to listen on for insecure forward source   | `24224`                          |
| `source.insecureForward.bind`      | Which addresses to bind to                            | `0.0.0.0`                        |
| `target.logzio.enable`             | Enable logzio target                                  | `false`                          |
| `target.logzio.token`              | The logzio token, required for the target             | `changeme`                       |
| `target.logzio.listener`           | The logzio listener                                   | `listener.logz.io:8071`          |
| `target.logzio.log_type`           | The log type to set in logzio                         | `cluster-logs`                   |
| `target.stdout.enable`             | Enable stdout target                                  | `false`                          |
| `resources`                        |                                                       | `{}`                             |
| `nodeSelector`                     |                                                       | `{}`                             |
| `tolerations`                      |                                                       | `[]`                             |
| `affinity`                         |                                                       | `{}`                             |


### Fluentd default config

The default configuration does nothing but load another configuration file which is created by helm. If you want to *fully* roll your own config you overwrite this key. More customized options to add / change sections of the included file will most probably follow.

This is the default configuration:

```
# just include config.d/*.conf ... so we're flexible :)
@include chart.conf
```
