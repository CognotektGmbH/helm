{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- .Values.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "chart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := .Values.name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart.label" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "helpers.list-env-variables"}}

{{ if .Values.external }}
{{- range .Values.external }}
- name: {{ .name}}
{{ if .value }}
  value: {{ quote .value }}
{{ else if .valueFrom }}
  valueFrom:
  {{ if .valueFrom.secretKeyRef }}
    secretKeyRef:
      name: {{ .valueFrom.secretKeyRef.name }}
      key: {{ .valueFrom.secretKeyRef.key }}
      optional: {{ .valueFrom.secretKeyRef.optional }}
  {{ else if .valueFrom.configMapKeyRef }}
    configMapKeyRef:
      name: {{ .valueFrom.configMapKeyRef.name }}
      key: {{ .valueFrom.configMapKeyRef.key }}
      optional: {{ .valueFrom.configMapKeyRef.optional }}
  {{- end}}
{{- end}}
{{- end}}
{{- end}}


{{ if .Values.secret }}
{{- $secretname := .Values.secret.name -}}
{{- range $key, $val := .Values.env.secret }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretname }}
      key: {{ $key  }}
{{- end}}
{{- end}}

{{- range $key, $val := .Values.env.normal }}
- name: {{ $key }}
  value: {{ $val | quote }}
{{- end}}

{{- end }}
