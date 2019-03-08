#/bin/sh

make clean
./configure && make -j6 && sudo make install
# ./configure SSL_CFLAGS=-I/usr/include SSL_LIBS="-L/lib/x86_64-linux-gnu -lssl -lcrypto" && make -j6 && sudo make install
# ./configure CPPFLAGS=-I/usr/include LDFLAGS=-L/lib/x86_64-linux-gnu && make -j6 && sudo make install
