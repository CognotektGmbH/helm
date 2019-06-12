{{- define "gitlab-runner.runner-env-vars" }}
- name: CI_SERVER_URL
  value: {{ include "gitlab-runner.gitlabUrl" . }}
- name: CLONE_URL
  value: {{ default "" .Values.runners.cloneUrl | quote }}
- name: RUNNER_EXECUTOR
  value: "docker+machine"
- name: RUNNER_LIMIT
  value: {{ default "0" .Values.runners.limit | quote }}
- name: RUNNER_NAME
  value: {{ default "spot-runner" .Values.fullNameOverride | quote }}
- name: REGISTER_LOCKED
  {{ if or (not (hasKey .Values.runners "locked")) .Values.runners.locked -}}
  value: "true"
  {{- else -}}
  value: "false"
  {{- end }}
- name: RUNNER_TAG_LIST
  value: {{ default "" .Values.runners.tags | quote }}

{{- if .Values.runners.cache -}}
{{ include "gitlab-runner.cache" . }}
{{- end }}
{{- if .Values.runners.docker -}}
{{ include "gitlab-runner.docker" . }}
{{- end }}
{{- if .Values.runners.machine -}}
{{ include "gitlab-runner.machine" . }}
{{- end }}
{{- if .Values.envVars -}}
{{ range .Values.envVars }}
- name: {{ .name }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}
