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

    delete array["toto"]
    array[1] = "titi"
    array[2] = "tititutu"
    assert::assert(utils::is_unique_value_in_array("titi", array) == 1)
    assert::assert(utils::is_unique_value_in_array("tutu", array) == 0)
}
