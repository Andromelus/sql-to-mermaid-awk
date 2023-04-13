@namespace "utils"

function is_key_of_array(key, array) {
    for (array_key in array) {
        if (key == array_key) {
            return 1
        }
    }
    return 0
}


function is_unique_value_in_array(value, array) {
    for (key in array) {
        if (array[key] == value) {
            return 1
        }
    }
    return 0
}
