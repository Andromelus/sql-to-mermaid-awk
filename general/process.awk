@namespace "process"
@include "general/clean.awk"
@include "general/keywords.awk"

function process_query(query, referential, unknown_target_buffer, links, withs) {
    cleaned_query = cleaner::clean_query(query)
    for (i = 1; i <= NF; i++) {
        if ($i == "use") {
            keyword::handle_use(i)
        } 
        else if ($i == "drop") {
            keyword::handle_drop(i, referential)
        }
        else if ($i == "create") {
            keyword::handle_create(i, referential)
        }
        else if ($i == "from") {
            keyword::handle_from(i, referential, unknown_target_buffer, links, withs)
        }
        else if ($i == "with") {
            keyword::handle_cte(i, referential, unknown_target_buffer, links, withs)
        }
    }
}
