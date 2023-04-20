@namespace "process"
@include "src/main/clean.awk"
@include "src/main/keywords.awk"

function process_query(query, referential, unknown_target_buffer, links, withs) {
    $0 = cleaner::clean_query(query)
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
        else if ($i == "as(") {
            keyword::handle_cte(i, withs)
        }
        else if ($i == "join") {
            keyword::handle_join(i, referential, unknown_target_buffer, links, withs)
        }
        else if ($i == "insert") {
            keyword::handle_insert(i, referential)
        }
    }
}

function generate(referential, links) {
    d= "graph LR\n"
    for (key in referential) {
        d = d "subgraph "key"\n"
        split(referential[key], values, ",")
        for (v_index in values) {
            d = d key"."values[v_index]"("values[v_index]")\n"
        }
        d = d "end\n"
    }
    
    for (target in links) {
        split(links[target], sources, ",")
        for (s_index in sources) {
            d = d sources[s_index] "-->"  target "\n"
        }
    }
    return d
}
