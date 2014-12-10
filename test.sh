#!/bin/sh

export GOMAXPROCS=4

rm -f test.sqlite

./dcounter server -db=test.sqlite -client="127.0.0.1:9371" &
P=$!

sleep 1

echo 0
./dcounter cli -connect="127.0.0.1:9371" get test
./dcounter cli -connect="127.0.0.1:9371" inc test 1
./dcounter cli -connect="127.0.0.1:9371" inc test 1
echo 2
./dcounter cli -connect="127.0.0.1:9371" get test

kill -2 $P
wait $P

rm -f test.sqlite

