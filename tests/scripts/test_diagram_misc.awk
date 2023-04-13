@include "general/utils.awk"
@include "tests/assert.awk"

BEGIN {
    array[1] = 1
    delete array[1]
}
END {
    array["toto"] = 1
    assert::assert(utils::is_key_of_array("toto", array) == 1)
    assert::assert(utils::is_key_of_array("titi", array) == 0)
}
