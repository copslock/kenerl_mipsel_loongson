Received:  by oss.sgi.com id <S553763AbRAGPfK>;
	Sun, 7 Jan 2001 07:35:10 -0800
Received: from [194.90.113.98] ([194.90.113.98]:50692 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553753AbRAGPfE>;
	Sun, 7 Jan 2001 07:35:04 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id SAA17579
	for <linux-mips@oss.sgi.com>; Sun, 7 Jan 2001 18:38:21 +0200
Message-ID: <3A588C36.771FFC16@jungo.com>
Date:   Sun, 07 Jan 2001 17:33:10 +0200
From:   Michael Shmulevich <michaels@jungo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Compiling MILO on big-emdian
References: <Pine.GSO.3.96.1010105214251.9384G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello all,

I was compiling a milo-0.27 lately on i586 machine for mips32 platform.
I am using binutils 2.8.1 egcs1.0.3a, and glibc 2.0.6. I am using some custom
MIPS board
with QED RM5261 processor. I use patched 2.2.14 kernel which is known to compile
and run on my hardware.

./configure went smoothly, but at a build time I started to get problems. First,
I got missing <asm/pica.h>. After a short search I have found one in annals of
the Internet.

This didn't really help me, because finally I got an assembler errors for
libstand/cachectl.o:

[michaels@kobie libstand]$ make
mips-linux-gcc -Wall -O2 -mips2 -Wa,-mips3 -mcpu=r4400 -D__KERNEL__
-DLOADADDR=0x80600000 -DKERNELBASE=0x80000000 -DVERSION=0.27 -DDEBUG=1
-DBOOTMETHOD_ARC -nostdinc
-I/usr/local/lib/gcc-lib/mips-linux/egcs-2.90.29/include
-I/home/michaels/atlas/rg.mips/linux/include -I../libstand/include
-I../libarc/include -c cachectl.S -o cachectl.o
cachectl.S: Assembler messages:
cachectl.S:58: Error: absolute expression required `li'
cachectl.S:59: Warning: Instruction cache requires absolute expression
cachectl.S:60: Warning: Instruction cache requires absolute expression
cachectl.S:61: Warning: Instruction cache requires absolute expression
cachectl.S:62: Warning: Instruction cache requires absolute expression
cachectl.S:63: Warning: Instruction cache requires absolute expression
cachectl.S:64: Warning: Instruction cache requires absolute expression
cachectl.S:65: Warning: Instruction cache requires absolute expression
cachectl.S:66: Warning: Instruction cache requires absolute expression
<and many more like these>

Line 58 is
 li t1,CACHELINES-1
Line 59 is
  cache Index_Writeback_Inv_D,32(t0)

and obviously CACHELINES is not defined anywhere, not even within the kernel
source tree. At least not my patched 2.2.14. Also, I am confused what causes
cache to go crazy on Index_Writeback_Inv_D ...

So, if anyone has ideas, plase forward them on.
Also, I wonder if there is a public CVS repository for milo or any other
"authoritative" storage.

Thanks in advance,
Michael.
