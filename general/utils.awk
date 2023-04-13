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


function print_referential(referential) {
    print "referential -----"
    for (key in referential) {
        print key ": " referential[key]
    }
}

function print_links(links) {
    print "links -----"
    for (key in links) {
        print key ": " links[key]
    }
}

function print_withs(withs) {
    print "withs -----"
    for (key in withs) {
        print key ": " withs[key]
    }
}
