@include "general/process.awk"

BEGIN {
    FS = " "
    RS = ";"
    unknown_target_buffer[1] = 1
    delete unknown_target_buffer[1]
    links[1] = 1
    delete links[1]
    withs[1] = 1
    delete withs[1]
}
{
    process::process_query($0, referential, unknown_target_buffer, links, withs)
}
END {
    process::print_referential(referential)
    process::print_links(links)
}
