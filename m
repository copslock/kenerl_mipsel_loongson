Received:  by oss.sgi.com id <S553813AbQKCKVR>;
	Fri, 3 Nov 2000 02:21:17 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:39435 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553807AbQKCKVG>;
	Fri, 3 Nov 2000 02:21:06 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 22AF07CF1; Fri,  3 Nov 2000 10:21:05 +0000 (GMT)
Date:   Fri, 3 Nov 2000 10:21:05 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: More GCC problems
Message-ID: <20001103102105.A1787@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I posted the other day, with a problem compiling the GCC from oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/src
I think it was 17/10/2000 IIRC.

I am trying to build a static GCC (2.97) using egcs 1.0.3a

So, I tried the older 07-07-2000, and this does not work either....arrgh

gcc -c  -DIN_GCC    -W -Wall -Wtraditional -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes -pedantic -Wno-long-long -O2 -g -O2  -DHAVE_CONFIG_H    -I. -I../../gcc -I../../gcc/config -I../../gcc/../include \
  ../../gcc/gencheck.c
cc1: Invalid option `-Wno-long-long'
make[2]: *** [gencheck.o] Error 1
make[2]: Leaving directory `/mnt/hd2/lfstmp/gcc-000707/gcc-build/gcc'
make[1]: *** [bootstrap] Error 2


I tried running make in the gcc directory, and get:

gcc -c  -DIN_GCC    -g  -W -Wall -Wtraditional -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes  -DHAVE_CONFIG_H    -I. -I../../gcc -I../../gcc/config -I../../gcc/../include ../../gcc/fold-const.c
../../gcc/fold-const.c: In function `div_and_round_double':
../../gcc/fold-const.c:676: warning: comparison between signed and unsigned
../../gcc/fold-const.c: In function `optimize_bit_field_compare':
../../gcc/fold-const.c:2936: warning: comparison between signed and unsigned
../../gcc/fold-const.c: In function `fold':
../../gcc/fold-const.c:5726: warning: comparison between signed and unsigned
../../gcc/fold-const.c:5737: warning: comparison between signed and unsigned
/tmp/cca08866.s: Assembler messages:
/tmp/cca08866.s:27593: Error: Branch out of range
/tmp/cca08866.s:27632: Error: Branch out of range
/tmp/cca08866.s:27637: Error: Branch out of range
make: *** [fold-const.o] Error 1
[root@dale:/mnt/hd2/lfstmp/gcc-000707/gcc-build/gcc]# 



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
