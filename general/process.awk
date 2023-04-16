@namespace "process"
@include "general/clean.awk"
@include "general/keywords.awk"

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
    print "graph LR"
    for (key in referential) {
        print "subgraph "key
        split(referential[key], values, ",")
        for (v_index in values) {
            print key"."values[v_index]"("values[v_index]")"
        }
        print "end"
    }
    
    for (target in links) {
        split(links[target], sources, ",")
        for (s_index in sources) {
            print sources[s_index] "-->"  target 
        }
    }
}
