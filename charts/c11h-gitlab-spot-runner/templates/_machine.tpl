{{- define "gitlab-runner.machine" }}
- name: MACHINE_OFF_PEAK_IDLE_TIME
  value: {{ default "" .Values.runners.machine.offPeakIdleTime | quote }}
- name: MACHINE_OFF_PEAK_IDLE_COUNT
  value: {{ default "" .Values.runners.machine.offPeakIdleCount | quote }}
- name: MACHINE_OFF_PEAK_TIMEZONE
  value: {{ default "" .Values.runners.machine.offPeakTimezone | quote }}
- name: MACHINE_OFF_PEAK_PERIODS
  value: {{ default "" .Values.runners.machine.offPeakPeriods | quote }}
- name: MACHINE_IDLE_TIME
  value: {{ default "" .Values.runners.machine.idleTime | quote }}
- name: MACHINE_IDLE_COUNT
  value: {{ default "" .Values.runners.machine.idleCount | quote }}
- name: MACHINE_MAX_BUILDS
  value: {{ default "" .Values.runners.machine.maxBuilds | quote }}
- name: MACHINE_DRIVER
  value: {{ default "" .Values.runners.machine.driver | quote }}
- name: MACHINE_NAME
  value: {{ default "standard-%s" .Values.runners.machine.name | quote }}
{{- end -}}
