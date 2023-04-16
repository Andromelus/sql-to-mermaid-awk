@include "src/main/process.awk"
@include "src/main/utils.awk"

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
    d = process::generate(referential, links)
    html_content = utils::readfile("src/resources/html.html")
    gsub("{{MERMAID_DIAGRAM}}", d, html_content)
    print html_content

}
