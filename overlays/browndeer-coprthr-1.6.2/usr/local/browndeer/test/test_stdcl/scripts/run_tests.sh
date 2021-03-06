#!/bin/bash

run_test() {

	./getndev.x --dev >& /dev/null
	ndev=$?
	for (( i=0; i<$ndev; i++ ))
	do 
		printf "%-68s" "$1 $2 $3 (stddev $i)"
		$1 --size $2 --blocksize $3 --dev $i >& /dev/null
		if [ $? -eq 0 ]; then
			printf "%10s\n" "[pass]"
		else 
			printf "%10s\n" "[failed]"
		fi;
	done

	./getndev.x --cpu >& /dev/null
	ndev=$?
	for (( i=0; i<$ndev; i++ ))
	do 
		printf "%-68s" "$1 $2 $3 (stdcpu $i)"
		$1 --size $2 --blocksize $3 --cpu $i >& /dev/null
		if [ $? -eq 0 ]; then
			printf "%10s\n" "[pass]"
		else 
			printf "%10s\n" "[failed]"
		fi;
	done

	./getndev.x --gpu >& /dev/null
	ndev=$?
	for (( i=0; i<$ndev; i++ ))
	do
		printf "%-68s" "$1 $2 $3 (stdgpu $i)"
		$1 --size $2 --blocksize $3 --gpu $i >& /dev/null
		if [ $? -eq 0 ]; then
			printf "%10s\n" "[pass]"
		else 
			printf "%10s\n" "[failed]"
		fi;
	done
}


echo -e "\nCHECK ENVIRONMENT ...";

test_lib_opencl=`ldd ./getndev.x | grep 'libOpenCL.so' | grep -o 'not found'`
test_lib_stdcl=`ldd ./getndev.x | grep 'libstdcl.so' | grep -o 'not found'`

if test "x$test_lib_opencl" = "xnot found"; then
   echo "libOpenCL.so not found, check LD_LIBRARY_PATH";
   exit -1;
fi;
if test "x$test_lib_stdcli" = "xnot found"; then
   echo "libstdcl.so not found, check LD_LIBRARY_PATH";
   exit -1;
fi;



echo -e "\nRUNNING TESTS ...";

for t in $*; do

run_test ./$t 128 1
run_test ./$t 128 2
run_test ./$t 128 4
run_test ./$t 128 8
run_test ./$t 128 16
run_test ./$t 128 32

run_test ./$t 256 1
run_test ./$t 256 2
run_test ./$t 256 4
run_test ./$t 256 8
run_test ./$t 256 16
run_test ./$t 256 32

run_test ./$t  65536  1
run_test ./$t  65536  2
run_test ./$t  65536  4
run_test ./$t  65536  8
run_test ./$t  65536  16
run_test ./$t  65536  32

run_test ./$t  1048576  1
run_test ./$t  1048576  2
run_test ./$t  1048576  4
run_test ./$t  1048576  8
run_test ./$t  1048576  16
run_test ./$t  1048576  32

done

echo -e "... TESTS COMPLETE.";

