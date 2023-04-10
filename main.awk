@include "general/process.awk"

BEGIN {
    FS = " "
    RS = ";"
}
{
    process::process_query($0, referential)
}
END {
    process::print_referential(referential)
}
