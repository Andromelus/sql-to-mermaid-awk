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
    if (word != "(") {
        len = split(word, a, ".")
        # if dot in word
        if (len == 2) {
            diagram::handle_referential(word, referential)
            diagram::handle_link(word, links, unknown_target_buffer)
        } else {
            is_in_with = utils::is_unique_value_in_array(word, withs)
            if (is_in_with == 0) {
                diagram::handle_referential(word, referential)
                diagram::handle_link(word, links, unknown_target_buffer)
            }
        }
    }
}

function handle_cte(cte_word_index, withs) {
    # the name of the cte is before the word
    word_index = cte_word_index - 1
    word = $word_index
    diagram::append_to_withs(word, withs)
}

function handle_join(join_word_index, referential, unknown_target_buffer, links, withs) {
    handle_from(join_word_index, referential, unknown_target_buffer, links, withs)
}
