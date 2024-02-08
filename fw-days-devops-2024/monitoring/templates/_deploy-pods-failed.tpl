{{- define "monitoring.failedPodsMonitor" -}}
apiVersion: datadoghq.com/v1alpha1
kind: DatadogMonitor
metadata:
  name: pods-failed
  namespace: datadog
spec:
  query: "change(avg(last_5m),last_5m):sum:kubernetes_state.pod.status_phase{phase:failed,kube_cluster_name:{{ include "monitoring.clusterName" . }},kube_deployment:{{ include "monitoring.deployName" . }}} > {{ include "monitoring.failedPodsCriticalThreshold" . }}"
  type: "query alert"
  name: "[kubernetes] Monitor Kubernetes Failed Pods in Namespaces"
  message: "More than ten pods are failing in (`{{`kube_cluster_name.name`}}` cluster). \n The threshold of ten pods varies depending on your infrastructure. Change the threshold to suit your needs."
  tags:
    - "integration:kubernetes"
{{- end -}}
