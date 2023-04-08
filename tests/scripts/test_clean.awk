@include "general/clean.awk"
@include "tests/assert.awk"
BEGIN {
    one_space = " "
    two_spaces = "  "
    more_spaces = "     "
}
END {
    assert::assert(cleaner::clean_query(one_space) == one_space, "one space to one space")
    assert::assert(cleaner::clean_query(two_spaces) == one_space, "two spaces to one space")
    assert::assert(cleaner::clean_query(more_spaces) == one_space, "more spaces to one space")
}
