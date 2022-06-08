{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "rabbitmq.common.labels.standard" -}}
app.kubernetes.io/name: {{ include "rabbitmq.common.names.name" . }}
helm.sh/chart: {{ include "rabbitmq.common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "rabbitmq.common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "rabbitmq.common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
