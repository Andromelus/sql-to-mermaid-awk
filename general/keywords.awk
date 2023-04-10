@namespace "keyword"
@include "general/diagram_handler.awk"

function handle_use(word_index) {
    db_index = word_index + 1
    db_name = $db_index
    diagram::set_default_database(db_name)
}


function handle_drop(drop_word_index, referential) {
    word_index = drop_word_index + 2
    word = $word_index
    diagram::handle_referential(word, referential)
}
