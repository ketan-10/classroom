package models


type TableDTO struct {
	TableName string
	Columns   []*Column
}

type TableWithIndex struct {
	Table   *TableDTO
	Indexes []*Index
}

type TableRelations struct {
	Table                *TableDTO
	Indexes              []*Index
	ForeignKeys          []*ForeignKey // foregin keys of this table, one to Many
	ForeignKeysRef        []*ForeignKey // other tables pointing to our table, Many To One
	GraphQLIncludeFields map[string]string
}

type EnumDTO struct {
	*Enum
	DatabaseName string
	Values       []string
}
