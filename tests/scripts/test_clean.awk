@include "src/main/clean.awk"
@include "tests/assert.awk"
BEGIN {
    one_space = "- -"
    two_spaces = "-   -"
    more_spaces = "-       -"

    new_line = "\n"

    external_keyword = "external"
    if_not_exists_keyword = "if not exists"
    if_exists_keyword = "if exists"
    upper_case = "TOTO"
    parenthesis_open = "-(-"
    parenthesis_close = "-)-"
    bracket_open = "-{-"
    bracket_close = "-}-"
    coma_1 = "-,-"
    coma_2 = "','"
    coma_3 = "\",\""

    lstrip = "  +++"
    rstrip = "+++   "

    as = "as ("

    single_line_comment_1 = "start\n--titi\nend"
    single_line_comment_2 = "start\n#titi\nend"
    multiple_line_comment = "start/*titi\ntutu*/end/*toto\n*/\nend2/*t*/"

}
END {
    assert::assert(cleaner::clean_query(one_space) == one_space, "one space to one space")
    assert::assert(cleaner::clean_query(two_spaces) == one_space, "two spaces to one space")
    assert::assert(cleaner::clean_query(more_spaces) == one_space, "more spaces to one space")

    assert::assert(cleaner::clean_query(new_line) == "", "new line to empty")
    assert::assert(cleaner::clean_query(upper_case) == "toto", "upper to lower")
    assert::assert(cleaner::clean_query(parenthesis_open) == "- ( -", "parenthesis open")
    assert::assert(cleaner::clean_query(parenthesis_close) == "- ) -", "parenthesis close")
    
    assert::assert(cleaner::clean_query(bracket_open) == "--", "bracket open")
    assert::assert(cleaner::clean_query(bracket_close) == "--", "bracket close")

    assert::assert(cleaner::clean_query(external_keyword) == "", "external_keyword")
    assert::assert(cleaner::clean_query(if_not_exists_keyword) == "", "if_not_exists_keyword")
    assert::assert(cleaner::clean_query(if_exists_keyword) == "", "if_exists_keyword")

    assert::assert(cleaner::clean_query(coma_1) == "- , -", "coma_1")
    assert::assert(cleaner::clean_query(coma_2) == "", "coma_2")
    assert::assert(cleaner::clean_query(coma_3) == "", "coma_3")

    # changed to "+" because "--" will be removed (sql comment handling)
    assert::assert(cleaner::clean_query(lstrip) == "+++", "lstrip")
    assert::assert(cleaner::clean_query(rstrip) == "+++", "rstrip")

    assert::assert(cleaner::clean_query(as) == "as(", "as")

    assert::assert(cleaner::__remove_single_line_comments(single_line_comment_1, "--") == "start\nend", "single line --")
    assert::assert(cleaner::__remove_single_line_comments(single_line_comment_2, "#") == "start\nend", "single line #")
    assert::assert(cleaner::__remove_multiline_comments(multiple_line_comment) == "startend\nend2", "multi line")

    assert::print_stats()
}
