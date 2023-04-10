exit_info() {
    if [ $? -ne 0 ]; then
        echo "ERROR - Something wrong happened"
    else
        echo "INFO - tests sucessful"
    fi
}

trap 'exit_info' EXIT

for file in ./tests/scripts/*.awk; do
    echo "launching $file"
    echo "" | awk -f $file
done
# echo "" | awk -f tests/scripts/test_clean.awk
