@namespace "cleaner"

function clean_query(query) {
    query = tolower(query)
    gsub("\n", " ", query)
    gsub("\\(", " ( ", query)
    gsub("\\)", " ) ", query)
    gsub("{", "", query)
    gsub("}", "", query)
    gsub("external", " ", query)
    gsub("if not exists", " ", query)
    gsub("if exists", " ", query)
    gsub("','", "", query)
    gsub("\",\"", "", query)
    gsub(",", " , ", query)
    gsub("as *\\(", "as(", query)
    gsub(" {2,}", " ", query)
    gsub(" {1,}$", "", query)
    gsub("^ {1,}", "", query)
    return query
}
