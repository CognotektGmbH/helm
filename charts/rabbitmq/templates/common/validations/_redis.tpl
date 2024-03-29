
{{/* vim: set filetype=mustache: */}}
{{/*
Validate Redis required passwords are not empty.

Usage:
{{ include "rabbitmq.common.validations.values.redis.passwords" (dict "secret" "secretName" "subchart" false "context" $) }}
Params:
  - secret - String - Required. Name of the secret where redis values are stored, e.g: "redis-passwords-secret"
  - subchart - Boolean - Optional. Whether redis is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.validations.values.redis.passwords" -}}
  {{- $existingSecret := include "rabbitmq.common.redis.values.existingSecret" . -}}
  {{- $enabled := include "rabbitmq.common.redis.values.enabled" . -}}
  {{- $valueKeyPrefix := include "rabbitmq.common.redis.values.keys.prefix" . -}}
  {{- $valueKeyRedisPassword := printf "%s%s" $valueKeyPrefix "password" -}}
  {{- $valueKeyRedisUsePassword := printf "%s%s" $valueKeyPrefix "usePassword" -}}

  {{- if and (not $existingSecret) (eq $enabled "true") -}}
    {{- $requiredPasswords := list -}}

    {{- $usePassword := include "rabbitmq.common.utils.getValueFromKey" (dict "key" $valueKeyRedisUsePassword "context" .context) -}}
    {{- if eq $usePassword "true" -}}
      {{- $requiredRedisPassword := dict "valueKey" $valueKeyRedisPassword "secret" .secret "field" "redis-password" -}}
      {{- $requiredPasswords = append $requiredPasswords $requiredRedisPassword -}}
    {{- end -}}

    {{- include "rabbitmq.common.validations.values.multiple.empty" (dict "required" $requiredPasswords "context" .context) -}}
  {{- end -}}
{{- end -}}

{{/*
Redis Auxiliar function to get the right value for existingSecret.

Usage:
{{ include "rabbitmq.common.redis.values.existingSecret" (dict "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether Redis is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.redis.values.existingSecret" -}}
  {{- if .subchart -}}
    {{- .context.Values.redis.existingSecret | quote -}}
  {{- else -}}
    {{- .context.Values.existingSecret | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliar function to get the right value for enabled redis.

Usage:
{{ include "rabbitmq.common.redis.values.enabled" (dict "context" $) }}
*/}}
{{- define "rabbitmq.common.redis.values.enabled" -}}
  {{- if .subchart -}}
    {{- printf "%v" .context.Values.redis.enabled -}}
  {{- else -}}
    {{- printf "%v" (not .context.Values.enabled) -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliar function to get the right prefix path for the values

Usage:
{{ include "rabbitmq.common.redis.values.key.prefix" (dict "subchart" "true" "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether redis is used as subchart or not. Default: false
*/}}
{{- define "rabbitmq.common.redis.values.keys.prefix" -}}
  {{- if .subchart -}}redis.{{- else -}}{{- end -}}
{{- end -}}
