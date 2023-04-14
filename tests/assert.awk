@namespace "assert"
# source: https://www.gnu.org/software/gawk/manual/html_node/Assert-Function.html
function assert(condition, string)
{
    __inc_test_count()
    if (! condition) {
        printf("%s: assertion failed: %s\n",
            FILENAME, string) > "/dev/stderr"
        _assert_exit = 1
        exit 1
    }
}

function __inc_test_count() {
    count = count + 1
}

function print_stats() {
    print "    executed " count " tests." 
}
