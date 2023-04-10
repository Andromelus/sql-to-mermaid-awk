@namespace "keyword"
@include "general/diagram_handler.awk"

function handle_use(word_index) {
    db_index = word_index + 1
    db_name = $db_index
    diagram::set_default_database(db_name)
}
