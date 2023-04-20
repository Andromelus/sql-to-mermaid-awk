@include "src/main/diagram_handler.awk"
@include "tests/assert.awk"

BEGIN {
    unknown_target_buffer[1] = 1
    delete unknown_target_buffer[1]
    links[1] = 1
    delete links[1]
}
END {

    diagram::handle_link("db.table", links, unknown_target_buffer)
    assert::assert(unknown_target_buffer[1] == "db.table")
    assert::assert(length(links) == 0)
    delete unknown_target_buffer[1]

    diagram::set_default_database("default_db")
    diagram::handle_link("table", links, unknown_target_buffer)
    assert::assert(unknown_target_buffer[1] == "default_db.table")
    assert::assert(length(links) == 0)
    delete unknown_target_buffer[1]

    diagram::set_element_being_created("database.table1")
    diagram::handle_link("database.table2", links, unknown_target_buffer)
    assert::assert(links["database.table1"] == "database.table2")
    diagram::handle_link("database.table3", links, unknown_target_buffer)
    assert::assert(links["database.table1"] == "database.table2,database.table3")
    diagram::handle_link("database.table4", links, unknown_target_buffer)
    assert::assert(links["database.table1"] == "database.table2,database.table3,database.table4")

    diagram::set_element_being_created("database.toto")
    diagram::handle_link("database.table2", links, unknown_target_buffer)
    assert::assert(links["database.toto"] == "database.table2")
    assert::print_stats()

}
