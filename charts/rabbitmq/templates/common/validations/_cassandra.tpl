{{/* vim: set filetype=mustache: */}}
{{/*
Validate Cassandra required passwords are not empty.

Usage:
{{ include "rabbitmq.common.validations.values.cassandra.passwords" (dict "secret" "secretName" "subchart" false "context" $) }}
Params:
  - secret - String - Required. Name of the secret where Cassandra values are stored, e.g: "cassandra-passwords-secret"
  - subchart - Boolean - Optional. Whether Cassandra is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.validations.values.cassandra.passwords" -}}
  {{- $existingSecret := include "rabbitmq.common.cassandra.values.existingSecret" . -}}
  {{- $enabled := include "rabbitmq.common.cassandra.values.enabled" . -}}
  {{- $dbUserPrefix := include "rabbitmq.common.cassandra.values.key.dbUser" . -}}
  {{- $valueKeyPassword := printf "%s.password" $dbUserPrefix -}}

  {{- if and (not $existingSecret) (eq $enabled "true") -}}
    {{- $requiredPasswords := list -}}

    {{- $requiredPassword := dict "valueKey" $valueKeyPassword "secret" .secret "field" "cassandra-password" -}}
    {{- $requiredPasswords = append $requiredPasswords $requiredPassword -}}

    {{- include "rabbitmq.common.validations.values.multiple.empty" (dict "required" $requiredPasswords "context" .context) -}}

  {{- end -}}
{{- end -}}

{{/*
Auxiliar function to get the right value for existingSecret.

Usage:
{{ include "rabbitmq.common.cassandra.values.existingSecret" (dict "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether Cassandra is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.cassandra.values.existingSecret" -}}
  {{- if .subchart -}}
    {{- .context.Values.cassandra.dbUser.existingSecret | quote -}}
  {{- else -}}
    {{- .context.Values.dbUser.existingSecret | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliar function to get the right value for enabled mariadb.

Usage:
{{ include "rabbitmq.common.cassandra.values.enabled" (dict "context" $) }}
*/}}
{{- define "rabbitmq.common.cassandra.values.enabled" -}}
  {{- if .subchart -}}
    {{- printf "%v" .context.Values.cassandra.enabled -}}
  {{- else -}}
    {{- printf "%v" (not .context.Values.enabled) -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliar function to get the right value for the key dbUser

Usage:
{{ include "rabbitmq.common.cassandra.values.key.dbUser" (dict "subchart" "true" "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether Cassandra is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.cassandra.values.key.dbUser" -}}
  {{- if .subchart -}}
    cassandra.dbUser
  {{- else -}}
    dbUser
  {{- end -}}
{{- end -}}
