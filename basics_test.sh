test -e ssshtest || wget -qhttps://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest
. ssshtest

run style_style_test pycodestyle style.py
assert_no_stdout

run style_columnstats_test pycodestyle get_column_stats.py
assert_no_stdout

(for i in `seq 1 100`; do 
    echo -e "$RANDOM\t$RANDOM\t$RANDOM\t$RANDOM\t$RANDOM";
done )> data.txt

run column_check python get_column_stats.py data.txt 7
assert stderr "column number input is greater than number of columns"
assert_exit_code 1

touch empty_data.txt
run file_not_empty python get_column_stats.py empty_data.txt 2
assert stderr "file is empty"
assert_exit_code 1

run file_doesnt_exist python get_column_stats.py not_a_file.txt 2
assert stderr "File not found"
assert_exit_code 1

run does_it_run python get_column_stats.py data.txt 2
assert stdout
assert_exit_code 0

V=1
(for i in `seq 1 100`; do 
    echo -e "$V\t$V\t$V\t$V\t$V";
done )> data.txt

python get_column_stats.py data.txt 2
assert stdout
assert_exit_code 0

