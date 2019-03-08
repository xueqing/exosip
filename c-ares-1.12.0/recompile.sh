#/bin/sh

make clean
./configure && make -j6 && sudo make install