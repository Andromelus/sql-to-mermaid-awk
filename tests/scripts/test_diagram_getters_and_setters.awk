@include "src/main/diagram_handler.awk"
@include "tests/assert.awk"

BEGIN {
    unknown_target_buffer[1] = 1
    delete unknown_target_buffer[1]
    withs[1] = 1
    delete withs[1]
}
END {
    diagram::set_element_being_created("toto.titi")
    assert::assert(diagram::get_element_being_created() == "toto.titi", "element being created")

    diagram::set_default_database("toto")
    assert::assert(diagram::get_default_database() == "toto", "default database")

    diagram::append_to_unknown_target_buffer("toto", unknown_target_buffer)
    assert::assert(unknown_target_buffer[1] == "toto", "set in unknown target buffer")

    diagram::append_to_withs("toto", withs)
    assert::assert(withs[1] == "toto", "set in withs")

    diagram::append_to_withs("titi", withs)
    assert::assert(withs[2] == "titi", "set in withs")
    assert::print_stats()

}
