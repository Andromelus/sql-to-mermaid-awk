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

# Find next word in the line, ignoring those indicated.
# If you want the default ignore list, set ignore to empty string
# ignore defaults to the following values:
# - one space
# - table
# - into
# For custom behavior, provide words like: ignore="word1 word2 wordn"
function find_next_meaningful_word(index_start, ignore){
    if (ignore == "") {
        ignore = "table into"
    }
    # split ignore string into a table
    split(ignore, temp)
    # for each fields after the marked field
    for (i = index_start + 1; i <= NF; i++) {
        keep = 1
        # for each word to ignore
        for (key in temp) {
            # if the field's value matches a word to ignore, do not keep
            if ($i == temp[key]) {
                keep = 0
                break
            }
        }
        if (keep == 0) {
            continue
        }
        # If field's value is empty space, do not keep
        if ($i == " "){
            continue
        }
        return $i
    }
    #TODO raise error ?
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

# https://www.gnu.org/software/gawk/manual/html_node/Readfile-Function.html
function readfile(file, tmp, save_rs)
{
    save_rs = RS
    RS = "^$"
    getline tmp < file
    close(file)
    RS = save_rs

    return tmp
}