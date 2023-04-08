@namespace "cleaner"

multiple_space_regex = " {2,}"

function clean_query(query) {
    gsub(" {2,}", " ", query)
    return query
}
