@include "src/main/diagram_handler.awk"
@include "tests/assert.awk"

BEGIN {

}
END {
    diagram::set_default_database("default_db")
    diagram::handle_referential("table1", referential)
    assert::assert(referential["default_db"] == "table1", "handle ref no db")

    diagram::handle_referential("default_db.table2", referential)
    assert::assert(referential["default_db"] == "table1,table2", "handle ref with db")

    diagram::handle_referential("other_db.table2", referential)
    assert::assert(referential["default_db"] == "table1,table2", "handle ref new db")
    assert::assert(referential["other_db"] == "table2", "handle ref new db")
    assert::print_stats()

}
