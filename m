Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2003 13:02:32 +0100 (BST)
Received: from c08.tateyama.hu ([IPv6:::ffff:152.66.119.136]:42503 "HELO
	server.tateyama.hu") by linux-mips.org with SMTP
	id <S8225203AbTD2MC3> convert rfc822-to-8bit; Tue, 29 Apr 2003 13:02:29 +0100
Received: (qmail 19754 invoked from network); 29 Apr 2003 12:02:23 -0000
Received: from c22.tateyama.hu (HELO enterprise) (root@152.66.119.150)
  by c01.tateyama.hu with SMTP; 29 Apr 2003 12:02:23 -0000
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
Organization: Tateyama Ltd
To: linux-mips@linux-mips.org
Subject: linux 2.4.20 does not compile!
Date: Tue, 29 Apr 2003 14:10:06 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304291410.06718.wom@tateyama.hu>
Return-Path: <wom@tateyama.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wom@tateyama.hu
Precedence: bulk
X-list: linux-mips

hi!

I'm trying to cross compile a 2.4.20 kernel on i386. Everything
seems to be fine but at the end of the compilatin I got errors:

mips-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -fomit-frame-pointer -I 
/usr/src/linux-2.4.20/include/asm/gcc -G 0 -mno-abicalls -fno-pic 
-pipe -mips2 -Wa,--trap   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o binfmt_elf.c

binfmt_elf.c: In function `load_elf_interp':
binfmt_elf.c:278: `EF_MIPS_ABI2' undeclared (first use in this 
function)
binfmt_elf.c:278: (Each undeclared identifier is reported only once
binfmt_elf.c:278: for each function it appears in.)
binfmt_elf.c:278: `EF_MIPS_ABI' undeclared (first use in this 
function)
binfmt_elf.c: In function `load_elf_binary':
binfmt_elf.c:458: `EF_MIPS_ABI2' undeclared (first use in this 
function)
binfmt_elf.c:458: `EF_MIPS_ABI' undeclared (first use in this 
function)
binfmt_elf.c: In function `load_elf_library':
binfmt_elf.c:825: `EF_MIPS_ABI2' undeclared (first use in this 
function)
binfmt_elf.c:825: `EF_MIPS_ABI' undeclared (first use in this 
function)
make[2]: *** [binfmt_elf.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.20/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/fs'
make: *** [_dir_fs] Error 2

I also tried with the latest prepatch but it's the same.
I'm usng gcc 3.2.3 and binutils 2.13.

Does somebody know a working linux kernel on MIPS?

thanks,

gabor
