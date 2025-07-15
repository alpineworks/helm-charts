#!/bin/sh
{{- if eq (len $.Values.init.models ) 0 -}}
echo "No additional models defined"
{{- else }}
{{- range $models := .Values.init.models }}
{{- if $models.filename }}
wget -nc {{ $models.url }} -O /models/{{ $models.filename }}
{{- else }}
wget -nc {{ $models.url }} -P /models
{{- end }}
{{- end }}
{{- end }}