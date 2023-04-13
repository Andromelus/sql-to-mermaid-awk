@namespace "keyword"
@include "general/diagram_handler.awk"
@include "general/utils.awk"

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

function handle_create(create_word_index, referential) {
    word_index = create_word_index + 2
    word = $word_index
    diagram::handle_referential(word, referential)
    len = split(word,a ,".")
    if (len == 1) {
        word = diagram::get_default_database() "." word
    }
    diagram::set_element_being_created(word)
}

function handle_from(from_word_index, referential, unknown_target_buffer, links, withs) {
    word_index = from_word_index + 1
    word = $word_index
    print word "word in from"
    if (word != "(") {
        len = split(word, a, ".")
        # if no dot in word
        if (len == 1) {
            diagram::handle_referential(word, referential)
            diagram::handle_link(word, links, unknown_target_buffer)
        } else if (utils::is_key_of_array(word, withs) == 0) {
            diagram::handle_referential(word, referential)
            diagram::handle_link(word, links, unknown_target_buffer)
        }
    }
}
