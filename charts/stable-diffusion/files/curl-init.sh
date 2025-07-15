#!/bin/sh
{{- if eq (len $.Values.init.models ) 0 -}}
echo "No additional models defined"
{{- else }}
apk add --no-cache curl
cd models
{{- range $models := .Values.init.models }}
{{- if $models.filename }}
curl -Lo {{ $models.filename }} {{ $models.url }}
{{- else }}
curl -LO {{ $models.url }}
{{- end }}
{{- end }}
{{- end }}