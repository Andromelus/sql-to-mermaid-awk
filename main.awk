@include "general/clean.awk"

BEGIN {
    print var
    cleaned_query = cleaner::clean_query(var)
    print cleaned_query "final"
}
