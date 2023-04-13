@namespace "utils"

function is_key_of_array(key, array) {
    for (array_key in array) {
        if (key == array_key) {
            return 1
        }
    }
    return 0
}
