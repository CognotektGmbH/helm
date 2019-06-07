{{- define "gitlab-runner.docker" }}
- name: DOCKER_IMAGE
  value: {{ default "" .Values.runners.docker.image | quote }}
- name: DOCKER_PULL_POLICY
  value: {{ default "" .Values.runners.docker.pullPolicy | quote }}
- name: DOCKER_NETWORK_MODE
  value: {{ default "" .Values.runners.docker.networkMode | quote }}
{{-     if .Values.runners.docker.privileged }}
- name: DOCKER_PRIVILEGED
  value: "true"
{{-     end }}
{{- end -}}
