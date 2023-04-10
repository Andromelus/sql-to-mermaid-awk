@namespace "diagram"
# This file is dedicated to the handling of the diagram
# informations. It manages the following variables:
# - referential: a multidimensional array like: referential[db] = table1,table2
#   , etc. Which contains the databases name and the tables contained into it
# - default_database: a string representing the name of the default database 

function set_default_database(value) {
    default_database = value
}

function get_default_database() {
    return default_database
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
