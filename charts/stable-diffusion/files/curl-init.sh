#!/bin/sh
{{- if eq (len $.Values.init.models ) 0 -}}
echo "No additional models defined"
{{- else }}
apk add --no-cache curl
cd models

# Install system dependencies needed by OpenCV and GFPGAN
echo "Installing system dependencies..."
if command -v apt-get > /dev/null; then
    apt-get update && apt-get install -y libglib2.0-0 libgthread-2.0-0 libgtk-3-0 libgdk-pixbuf2.0-0
elif command -v apk > /dev/null; then
    apk add --no-cache glib gtk+3.0-dev
fi
{{- range $models := .Values.init.models }}
{{- if $models.filename }}
curl -Lo {{ $models.filename }} {{ $models.url }}
{{- else }}
curl -LO {{ $models.url }}
{{- end }}
{{- end }}

# Download CLIP model for offline use
{{- if .Values.init.clipModel.enabled }}
echo "Downloading CLIP model..."
mkdir -p {{ .Values.init.clipModel.localPath }}
cd {{ .Values.init.clipModel.localPath }}
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/config.json
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/tokenizer.json
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/tokenizer_config.json
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/vocab.json
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/merges.txt
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/special_tokens_map.json
curl -LO {{ .Values.init.clipModel.repoUrl }}/resolve/main/pytorch_model.bin
{{- end }}
{{- end }}