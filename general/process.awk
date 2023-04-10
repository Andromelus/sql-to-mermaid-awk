@namespace "process"
@include "general/clean.awk"
@include "general/keywords.awk"

function process_query(query, referential) {
    cleaned_query = cleaner::clean_query(query)
    for (i = 1; i <= NF; i++) {
        if ($i == "use") {
            keyword::handle_use(i)
        } 
        else if ($i == "drop") {
            print "drop"
            word_index = i + 2
            word = $word_index
            keyword::handle_drop(i, referential)
        }
    }
}

function print_referential(referential) {
    for (key in referential) {
        print key "-" referential[key]
    }
}
