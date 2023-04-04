package templates

type TemplateType uint16

const (
	ENUM TemplateType = iota
	TABLE
	REPO
	XO_WIRE
	GRAPH_SCHEMA
	RLTS
)

func (tt *TemplateType) String() string {
	switch *tt {
	case ENUM:
		return "enum"
	case TABLE:
		return "table"
	case REPO:
		return "repo"
	case XO_WIRE:
		return "xo_wire"
	case RLTS:
		return "rlts"
	case GRAPH_SCHEMA:
		return "schema"
	}

	return ""
}


func (tt *TemplateType) Extension() string {
	switch *tt {
	case ENUM:
		return "go"
	case TABLE:
		return "go"
	case REPO:
		return "go"
	case XO_WIRE:
		return "go"
	case RLTS:
		return "go"
	case GRAPH_SCHEMA:
		return "graphql"
	}

	return ""
}