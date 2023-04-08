{{- $name := joinWith "_" .TableName .ColumnName -}}
{{ $camelName := camelCase $name }}
{{- $shortName := shortName $camelName -}}
package enum

type {{ $camelName }} uint16

const (
{{ range .Values }}
    {{ $camelName -}}{{- camelCase . }} {{ $camelName }} = iota 
{{ end }}
)

func ({{ $shortName }} {{ $camelName }}) String() string {
    var value string

    switch {{ $shortName }} {
        {{ range .Values }}
        case {{ $camelName -}}{{- camelCase . }}:
            value = "{{.}}" 
        {{ end }}
    }

    return value
}

func ({{ $shortName }} {{ $camelName }}) GoString() string {
    return {{ $shortName }}.String()
}

// MarshalGQL implements the graphql.Marshaler interface
func ({{ $shortName }} {{ $camelName }}) MarshalGQL(w io.Writer) {
	w.Write([]byte(`"` + {{ $shortName }}.String() + `"`))
}

// UnmarshalGQL implements the graphql.Marshaler interface
func ({{ $shortName }} *{{ $camelName }}) UnmarshalGQL(v interface{}) error {
	if str, ok := v.(string); ok {
		return {{ $shortName }}.UnmarshalText([]byte(str))
	}
	return errors.New("ErrInvalidEnumGraphQL")
}

// MarshalText marshals {{ $camelName }} into text.
func ({{ $shortName }} {{ $camelName }}) MarshalText() ([]byte, error) {
	return []byte({{ $shortName }}.String()), nil
}

// UnmarshalText unmarshals {{ $camelName }} from text.
func ({{ $shortName }} *{{ $camelName }}) UnmarshalText(text []byte) error {
	switch string(text)	{

{{- range .Values }}
	case "{{.}}":
		*{{ $shortName }} = {{ $camelName -}}{{- camelCase . }}
{{ end }}

	default:
		return errors.New("ErrInvalidEnumGraphQL_{{ $camelName }}")
	}

	return nil
}

// Value satisfies the sql/driver.Valuer interface for {{ $camelName }}.
func ({{ $shortName }} {{ $camelName }}) Value() (driver.Value, error) {
	return {{ $shortName }}.String(), nil
}

// Value satisfies the sql/driver.Valuer interface for {{ $camelName }}.
func ({{ $shortName }} {{ $camelName }}) Ptr() *{{ $camelName }} {
	return &{{ $shortName }}
}

// Scan satisfies the database/sql.Scanner interface for {{ $camelName }}.
func ({{ $shortName }} *{{ $camelName }}) Scan(src interface{}) error {
	buf, ok := src.([]byte)
	if !ok {
	   return errors.New("ErrInvalidEnumScan_{{ $camelName }}")
	}

	return {{ $shortName }}.UnmarshalText(buf)
}
