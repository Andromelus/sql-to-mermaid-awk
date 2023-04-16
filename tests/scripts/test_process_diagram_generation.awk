@include "src/main/process.awk"
@include "tests/assert.awk"
BEGIN {
    referential["db1"] = "table1,table2"
    referential["db2"] = "table3,table4"

    links["db1.table2"] = "db1.table1"
    links["db2.table3"] = "db1.table1"
    links["db2.table4"] = "db1.table2,db2.table3"

}
END {
    expected_diag[1] = "graph LR\n"
    expected_diag[2] = "subgraph db1\n"
    expected_diag[3] = "db1.table1(table1)\n"
    expected_diag[4] = "db1.table2(table2)\n"
    expected_diag[5] = "end\n"
    expected_diag[6] = "subgraph db2\n"
    expected_diag[7] = "db2.table3(table3)\n"
    expected_diag[8] = "db2.table4(table4)\n"
    expected_diag[9] = "end\n"
    expected_diag[10] = "db1.table1-->db1.table2\n"
    expected_diag[11] = "db1.table1-->db2.table3\n"
    expected_diag[12] = "db1.table2-->db2.table4\n"
    expected_diag[13] = "db2.table3-->db2.table4\n"
    generated_diag = process::generate(referential, links)
    for (i in expected_diag) {
        pos = index(generated_diag, expected_diag[i])
        assert::assert(pos != 0, "check diagram generation")
    }
    assert::print_stats()
}
