Received:  by oss.sgi.com id <S553771AbQJNL7K>;
	Sat, 14 Oct 2000 04:59:10 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:47366 "HELO convert rfc822-to-8bit
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553762AbQJNL65>;
	Sat, 14 Oct 2000 04:58:57 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 759BD7C74; Sat, 14 Oct 2000 12:58:55 +0100 (BST)
Date:   Sat, 14 Oct 2000 12:58:55 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Cc:     wesolows@foobazco.org
Subject: CVS GCC Problem
Message-ID: <20001014125855.A28429@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I guess it's not my weekend  :(

I am trying to satup a cross compile environment on my x86 linux box (gcc 2.95.2
, glibc 2.1.3, binutils 2.10, linux-2.2.17)

I am building current CVS binutils and GCC of today with patches that Keith Weso
lowski sent me.                                                                

I have tried this 2 or 3 times, and get the same problem every time,..

mkdir /crossdev
mkdir /crossdev-build
mkdir /crossdev-build/gcc-build
mkdir /crossdev-build/binutils-build

cd /crossdev-build

cp -ax ~/cvs/linux-mips/src binutils
cp -ax  ~/cvs/linux-mips/gcc .

cd binutils
patch -p1 < /export/mips/patches/binutils-1009.diff 

cd ../gcc
patch -p0 < /export/mips/patches/gcc-000922.diff

cd ../binutils-build
../binutils/configure --prefix=/crossdev --target=mips-linux && make && make install

export PATH=$PATH:/crossdev/bin

cd ../gcc-build
AR=mips-linux-ar RANLIB=mips-linux-ranlib ../gcc/configure --prefix=/crossdev --target=mips-linux --with-newlib && make -C libiberty LANGUAGES=c && make -C gcc LANGUAGES=c

..This is where it goes wrong  :(

./xgcc -B./ -B/crossdev/mips-linux/bin/ -isystem /crossdev/mips-linux/include -O2  -DCROSS_COMPILE -DIN_GCC    `echo -g -W -Wall -Wtraditional -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes -pedantic -Wno-long-long|sed -e s/-pedantic//g -e s/-Wtraditional//g` -isystem ./include  -fPIC -g1  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -shared -nodefaultlibs -Wl,--soname=libgcc_s.so.0 -Wl,--version-script=libgcc.map -o libgcc_s.so   libgcc/./_muldi3.o libgcc/./_divdi3.o libgcc/./_moddi3.o libgcc/./_udivdi3.o libgcc/./_umoddi3.o libgcc/./_negdi2.o libgcc/./_lshrdi3.o libgcc/./_ashldi3.o libgcc/./_ashrdi3.o libgcc/./_ffsdi2.o libgcc/./_clz.o libgcc/./_udiv_w_sdiv.o libgcc/./_udivmoddi4.o libgcc/./_cmpdi2.o libgcc/./_ucmpdi2.o libgcc/./_floatdidf.o libgcc/./_floatdisf.o libgcc/./_fixunsdfsi.o libgcc/./_fixunssfsi.o libgcc/./_fixunsdfdi.o libgcc/./_fixdfdi.o libgcc/./_fixunssfdi.o libgcc/./_fixsfdi.o libgcc/./_fixxfdi.o libgcc/./_fixunsxfdi.o libgcc/./_floatdixf.o libgcc/./_fixunsxfsi.o libgcc/./_fixtfdi.o libgcc/./_fixunstfdi.o libgcc/./_floatditf.o libgcc/./__gcc_bcmp.o libgcc/./_varargs.o libgcc/./__dummy.o libgcc/./_eprintf.o libgcc/./_bb.o libgcc/./_shtab.o libgcc/./_clear_cache.o libgcc/./_trampoline.o libgcc/./__main.o libgcc/./_exit.o libgcc/./_ctors.o libgcc/./_eh.o libgcc/./frame-dwarf2.o -lc
/crossdev/mips-linux/bin/ld: cannot open crti.o: No such file or directory
collect2: ld returned 1 exit status
make[1]: *** [libgcc_s.so] Error 1
make[1]: Leaving directory `/crossdev-build/gcc-build/gcc'
make: *** [libgcc.a] Error 2
make: Leaving directory `/crossdev-build/gcc-build/gcc'


Any ideas?


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
