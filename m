Received:  by oss.sgi.com id <S553866AbQJOM0i>;
	Sun, 15 Oct 2000 05:26:38 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:21001 "HELO convert rfc822-to-8bit
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553862AbQJOM0P>;
	Sun, 15 Oct 2000 05:26:15 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 318AC7C75; Sun, 15 Oct 2000 13:26:10 +0100 (BST)
Date:   Sun, 15 Oct 2000 13:26:10 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Possible GCC Bug
Message-ID: <20001015132610.A30248@woody.ichilton.co.uk>
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

Compiling CVS GCC from yesturday, nativly, using egcs 1.0.3a and binutils 2.8.1

(CVS Binutils compiled fine without patches BTW)


if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
/mnt/hd2/lfstmp/gcc/gcc-build/gcc/xgcc -B/mnt/hd2/lfstmp/gcc/gcc-build/gcc/ -B/usr/mips-unknown-linux-gnu/bin/ -B/usr/mips-unknown-linux-gnu/lib/ -isystem /usr/mips-unknown-linux-gnu/include -O2   -DIN_GCC    `echo -g -O2 -W -Wall -Wtraditional -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes -pedantic -Wno-long-long|sed -e s/-pedantic//g -e s/-Wtraditional//g` -isystem ./include  -fPIC -g1  -DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED  -shared -nodefaultlibs -Wl,--soname=libgcc_s.so.0 -Wl,--version-script=libgcc.map -o libgcc_s.so   libgcc/./_muldi3.o libgcc/./_divdi3.o libgcc/./_moddi3.o libgcc/./_udivdi3.o libgcc/./_umoddi3.o libgcc/./_negdi2.o libgcc/./_lshrdi3.o libgcc/./_ashldi3.o libgcc/./_ashrdi3.o libgcc/./_ffsdi2.o libgcc/./_clz.o libgcc/./_udiv_w_sdiv.o libgcc/./_udivmoddi4.o libgcc/./_cmpdi2.o libgcc/./_ucmpdi2.o libgcc/./_floatdidf.o libgcc/./_floatdisf.o libgcc/./_fixunsdfsi.o libgcc/./_fixunssfsi.o libgcc/./_fixunsdfdi.o libgcc/./_fixdfdi.o libgcc/./_fixunssfdi.o libgcc/./_fixsfdi.o libgcc/./_fixxfdi.o libgcc/./_fixunsxfdi.o libgcc/./_floatdixf.o libgcc/./_fixunsxfsi.o libgcc/./_fixtfdi.o libgcc/./_fixunstfdi.o libgcc/./_floatditf.o libgcc/./__gcc_bcmp.o libgcc/./_varargs.o libgcc/./__dummy.o libgcc/./_eprintf.o libgcc/./_bb.o libgcc/./_shtab.o libgcc/./_clear_cache.o libgcc/./_trampoline.o libgcc/./__main.o libgcc/./_exit.o libgcc/./_ctors.o libgcc/./_eh.o libgcc/./frame-dwarf2.o -lc
/usr/bin/ld:libgcc.map:1: parse error in VERSION script
collect2: ld returned 1 exit status
make[3]: *** [libgcc_s.so] Error 1
make[3]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make[2]: *** [libgcc.a] Error 2
make[2]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make[1]: *** [stage_a] Error 2
make[1]: Leaving directory `/mnt/hd2/lfstmp/gcc/gcc-build/gcc'
make: *** [bootstrap] Error 2
bash-2.04# 


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
