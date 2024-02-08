{{- define "monitoring.deployName" -}}
{{ include "fw-demo.fullname" . }}
{{- end -}}

{{- define "monitoring.clusterName" -}}
{{- required "Cluster name (.Values.clusterName) is required." .Values.clusterName -}}
{{- end -}}

{{- define "monitoring.failedPodsCriticalThreshold" -}}
{{- .Values.monitoring.failedPodsCriticalThreshold | default 1 -}}
{{- end -}}
