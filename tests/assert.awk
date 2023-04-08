@namespace "assert"
# source: https://www.gnu.org/software/gawk/manual/html_node/Assert-Function.html
function assert(condition, string)
{
    if (! condition) {
        printf("%s:%d: assertion failed: %s\n",
            FILENAME, FNR, string) > "/dev/stderr"
        _assert_exit = 1
        exit 1
    }
}
