@namespace "diagram"
# This file is dedicated to the handling of the diagram
# informations. It manages the following variables:
# - referential: a multidimensional array like: referential[db] = table1,table2
#   , etc. Which contains the databases name and the tables contained into it
# - default_database: a string representing the name of the default database
@include "general/utils"

function set_default_database(value) {
    default_database = value
}

function get_default_database() {
    return default_database
}

function set_element_being_created(value) {
    element_being_created = value
}

function get_element_being_created() {
    return element_being_created
}

function append_to_unknown_target_buffer(value, unknown_target_buffer) {
    position = length(unknown_target_buffer) + 1
    unknown_target_buffer[position] = value
}

function append_to_withs(value, withs) {
    if (utils::is_unique_value_in_array(value, withs) == 0) {
        position = length(withs) + 1
        withs[position] = value
    }

}

# Update the referential with a new table. If the word contains a dot, the text
# before the dot is considered to be the database name, the text after the dot
# is considered as the table name. Otherwise, uses the default_database value
# https://www.gnu.org/software/gawk/manual/html_node/Pass-By-Value_002fReference.html
function handle_referential(word, referential) {
    database = ""
    table = ""

    len = split(word, splitted_word, ".")
    # The is no dot else there is dot
    if (len == 1) {
        database = get_default_database()
        table = word
    } else {
        database = splitted_word[1]
        table = splitted_word[2]
    }
    if (referential[database] == "") {
        referential[database] = table
    } else {
        referential[database] = referential[database] "," table
    }
}

# Update the links array. The array has the following structure:
# links[db.table] = [db1.table1, db2.table2] which means:
# db.table is created using db1.table1 and db2.table2
function handle_link(word, links, unknown_target_buffer) {
    len = split(word, a, ".")
    if (len == 1) {
        word = get_default_database() "." word
    }

    if (get_element_being_created() == "") {
        append_to_unknown_target_buffer(word, unknown_target_buffer)
        return
    }
    # TODO useful ? Default value is empty string
    if (utils::is_key_of_array(get_element_being_created(), links) == 0) {
        links[get_element_being_created()] = ""
    }

    len = split(links[get_element_being_created()], a, word)
    if (len == 0) {
        links[get_element_being_created()] =  word
    }
    if (len == 1) {
        links[get_element_being_created()] = links[get_element_being_created()] "," word
    }

}
