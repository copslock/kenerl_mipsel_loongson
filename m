Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 17:17:33 +0100 (BST)
Received: from c08.tateyama.hu ([IPv6:::ffff:152.66.119.136]:13329 "HELO
	server.tateyama.hu") by linux-mips.org with SMTP
	id <S8225072AbTD1QRa> convert rfc822-to-8bit; Mon, 28 Apr 2003 17:17:30 +0100
Received: (qmail 13980 invoked from network); 28 Apr 2003 16:17:29 -0000
Received: from c22.tateyama.hu (HELO enterprise) (root@152.66.119.150)
  by c01.tateyama.hu with SMTP; 28 Apr 2003 16:17:29 -0000
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
Organization: Tateyama Ltd
To: linux-mips@linux-mips.org
Subject: crosscompile doesn't work :(
Date: Mon, 28 Apr 2003 18:25:09 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304281825.09697.wom@tateyama.hu>
Return-Path: <wom@tateyama.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wom@tateyama.hu
Precedence: bulk
X-list: linux-mips

hi!

I'm totally new to MIPS and the bigger trouble that I'm also
new to cross compiling.
I will get a little MIPS board with PCMCIA, USB, serial,
Ethernet, 4Mb flash memory. I have to build a linux for it
from scratch but I have never done cross compiling before.

I use debian (Woody) and I installed the toolchain package,
configured for mipsel-linux, I built the binutils and gcc,
(binutils 2.12, gcc 3.2.3)

I did:
tpkg-make mipsel-linux
cd binutils
debuild
debi

tpkg-install-libc mipsel-linux

cd ../gcc-3.2.3
debuild
debi

I can compile a simple c code, but I can't compile the kernel.
I tried to compile 2.4.19 and I ran into trouble at the beginning:

the 'as' said that -mcpu option is not recognized. OK, I removed
this option. Then everything seemed to be fine but when the 
compilation arrived to the arch/mips directiory than I got the
following error messages:

make[1]: Leaving directory `/usr/src/linux/arch/mips/math-emu'
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -I /usr/src/linux/include/asm/gcc -G 
0 -mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap " -C  arch/mips/sni
make[1]: Entering directory `/usr/src/linux/arch/mips/sni'
mipsel-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -I /usr/src/linux/include/asm/gcc -G 
0 -mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap  -c int-handler.S -o 
int-handler.o
/usr/src/linux/include/asm/mipsregs.h: Assembler messages:
/usr/src/linux/include/asm/mipsregs.h:562: Error: unrecognized opcode 
`static inline void tlb_probe(void)'
/usr/src/linux/include/asm/mipsregs.h:563: Warning: rest of line 
ignored; first ignored character is `{'
/usr/src/linux/include/asm/mipsregs.h:564: Error: unrecognized opcode 
`__asm__ __volatile__('
/usr/src/linux/include/asm/mipsregs.h:565: Warning: rest of line 
ignored; first ignored character is `"'
/usr/src/linux/include/asm/mipsregs.h:566: Warning: rest of line 
ignored; first ignored character is `"'
/usr/src/linux/include/asm/mipsregs.h:567: Warning: rest of line 
ignored; first ignored character is `"'
/usr/src/linux/include/asm/mipsregs.h:568: Warning: rest of line 
ignored; first ignored character is `"'
/usr/src/linux/include/asm/mipsregs.h:569: Warning: rest of line 
ignored; first ignored character is `}'

The board chose was only a test bacause I don't know anything about
the board I'm going to use. There is a nice Japanese page about it,
but I can't read it.

http://www.tcs-8000.info/products/

Can anyone help? I have to bulid a complete little system in 4Mb 
within a month.

I also tried to build the cross compile environment from the sources
directly not using toolchain but I got much less success. it didn't
compile at all (gcc).

Thanks a lot,

Gabor
