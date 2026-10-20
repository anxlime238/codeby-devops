{{- define "wordpress.mysqlName" -}}
{{ .Release.Name }}-mysql
{{- end }}

{{- define "wordpress.wordpressName" -}}
{{ .Release.Name }}-wordpress
{{- end }}
