@include "src/main/keywords.awk"
@include "src/main/diagram_handler.awk"
@include "src/main/utils.awk"
@include "tests/assert.awk"

BEGIN {
    unknown_target_buffer[1] = 1
    delete unknown_target_buffer[1]
    links[1] = 1
    delete links[1]
    withs[1] = 1
    delete withs[1]
    referential[1] = 1
    delete referential[1]
}
END {
    #################### USE ####################
    $0 = "use db1"
    keyword::handle_use(1)
    assert::assert(diagram::get_default_database() == "db1", "handle use")

    #################### drop ####################
    $0 = "drop table db.toto"
    keyword::handle_drop(1, referential)
    assert::assert(referential["db"] == "toto", "handle drop")
    delete referential["db"]

    #################### create ####################
    $0 = "create table db.table"
    keyword::handle_create(1, referential)
    assert::assert(diagram::get_element_being_created() == "db.table", "create sets element being created")
    assert::assert(referential["db"] == "table", "create sets referential")
    delete referential["db"]
    diagram::set_element_being_created("")

    #################### from ####################
    $0 = "from ("
    keyword::handle_from(1, referential, unknown_target_buffer, links, withs)
    assert::assert(length(referential) == 0, "from subquery does nothing")

    $0 = "from db.table"
    keyword::handle_from(1, referential, unknown_target_buffer, links, withs)
    assert::assert(unknown_target_buffer[1] == "db.table", "from stores word into buffer if element being created is unknown")
    assert::assert(referential["db"] == "table", "from sets referential")
    delete referential["db"]
    delete unknown_target_buffer[1]

    $0 = "from db.table"
    diagram::set_element_being_created("db2.table2")
    keyword::handle_from(1, referential, unknown_target_buffer, links, withs)
    assert::assert(referential["db"] == "table", "from sets referential")
    assert::assert(links["db2.table2"] == "db.table", "from sets links")
    diagram::set_element_being_created("")
    delete referential["db"]
    delete links["db2.table2"]

    $0 = "from cte"
    diagram::set_element_being_created("db_create.table_create")
    diagram::append_to_withs("cte", withs)
    assert::assert(length(referential) == 0, "from does not set referential if meets cte name")
    assert::assert(length(links) == 0, "from does not set links if meets cte name")
    delete withs[1]

    #################### cte ####################
    $0 = "the_cte as("
    keyword::handle_cte(2, withs)
    assert::assert(withs[1] == "the_cte", "cte sets withs")
    delete withs[1]

    #################### join ####################
    # WORKS THE SAME AS FROM

    #################### insert ####################
    $0 = "insert into table db.table"
    keyword::handle_insert(1, referential)
    assert::assert(diagram::get_element_being_created() == "db.table", "insert sets element being created")
    assert::assert(referential["db"] = "table", "insert sets referential")

    assert::print_stats()
}
