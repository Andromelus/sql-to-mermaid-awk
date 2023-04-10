@namespace "process"
@include "general/clean.awk"
@include "general/keywords.awk"

function process_query(query) {
    cleaned_query = cleaner::clean_query(query)
    for (i = 1; i <= NF; i++) {
        if ($i == "use") {
            keyword::handle_use(i)
        } 
        else if ($i == "drop")
    }
}
