@namespace "cleaner"

function clean_query(query) {
    query = tolower(query)
    query = __remove_single_line_comments(query, "--")
    query = __remove_single_line_comments(query, "#")
    query = __remove_multiline_comments(query)
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

# for comments starting with "--" or "#"
function __remove_single_line_comments(query, comment_marker) {
    regex = "^"comment_marker
    filtered_query = ""
    split(query, s, "\n")
    for (key in s) {
        # remove leading spaces
        gsub("^ {1,}", "", s[key])
        # if does not starts with "--", keep
        if (match(s[key], regex) != 1) {
            if (filtered_query == ""){
                filtered_query = s[key]
            } else {
                filtered_query = filtered_query "\n" s[key]
            }
        }
    }
    return filtered_query
}

# for comments in /* */
function __remove_multiline_comments(query) {
    split(query, chars, "")
    keep = 1
    result = ""
    for (i=1; i<= length(chars); i++) {
        # if we are currently keeping chars
        if (keep == 1){
            # if we meet "/*" on the next two chars
            if (chars[i] == "/" && chars[i + 1] == "*") {
                # ignore further chars
                keep = 0
            } else {
                # else, keep it
                result = result chars[i]
            }
        }
        # if we are not currently keeping
        # and we meet "*/", then start keeping chars
        else if (keep == 0) {
            if (chars[i] == "*") {
                if (chars[i + 1] == "/") {
                    keep = 1
                    i = i + 1
                }
            }
        }
    }
    return result
}
