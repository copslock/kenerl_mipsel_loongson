Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2003 17:44:55 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23223 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225377AbTIEQox>; Fri, 5 Sep 2003 17:44:53 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA06957;
	Fri, 5 Sep 2003 18:44:41 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 5 Sep 2003 18:44:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Kesselring <dkesselr@mmc.atmel.com>
cc: linux-mips@linux-mips.org
Subject: Re: 64 bit compile problems
In-Reply-To: <Pine.GSO.4.44.0309050955460.26490-100000@ares.mmc.atmel.com>
Message-ID: <Pine.GSO.3.96.1030905182856.1692F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 5 Sep 2003, David Kesselring wrote:

> I'm trying to build u-boot bootloader for a 5kc core in 64 bit mode. I'm
> having problems with the compiler/linker. If anyone has any ideas, please
> let me know.
> 
> When I use the toolchain that installs in
> "/usr/cygnus/mips3264-020217/H-i686-pc-linux-gnulibc2.1/bin", I get a link
> problem where all opcodes are not aligned on a 64 bit boundry. I get an
> extra 32bit word of 0x0 between two 64bit opcodes in the binary file.
> The cpp options I use are:-mips64 -EL -mlong64 -mcpu=r5k

 I don't really understand -- MIPS regular opcodes (i.e. not in the MIPS16
mode) have to be aligned to 32-bit boundaries.  What do you mean by
"64-bit opcodes"?  If there is a null word (a "nop") between each pair of
emitted opcodes, then the resulting binary should still work, although
suboptimally.  It may be a bug in gcc or gas.  Does the output from gcc
contains the padding?  What are the versions of gcc and binutils? 

> When I use a toolchain which I think I ftp'd from linux-mips.org
> (mips64el-linux), I get the following error. The cpp options I use
> are:-EL -mabi=64 -mips4 -mlong64
> 
> 
> /usr/bin/mips64el-linux-gcc  -O   -D__KERNEL__ -DTEXT_BASE=0x00000
> -I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include
> -I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include/asm -fno-builtin
> -ffreestanding -nostdinc -isystem
> /usr/lib/gcc-lib/mips64el-linux/2.95.4/include -pipe  -DCONFIG_MIPS
> -D__MIPS__ -EL -mabi=64 -mips4
> -mlong64 -Wall -Wstrict-prototypes -c -o atmel352.o atmel352.c
> atmel352.c: In function `sdram_timing_init':
> atmel352.c:82: warning: cast to pointer from integer of different size
> atmel352.c:90: warning: cast to pointer from integer of different size
> atmel352.c: In function `copydwords':
> atmel352.c:186: Internal compiler error in `rtx_equal_for_memref_p', at
> alias.c:682
> Please submit a full bug report.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
> cpp0: output pipe has been closed

 That's interesting -- it's almost surely a bug in the RTL.  I may try to
reproduce it with my toolchain -- can you send me a preprocessed version
of this file?  If so, please run the following command and send me the
resulting atmel352.i file -- use `bzip2 -9' or `gzip -9' and send it
attached directly to me only to save net resources:

$ /usr/bin/mips64el-linux-gcc  -O   -D__KERNEL__ -DTEXT_BASE=0x00000
-I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include
-I/home/dkesselr/uboot/u-boot-0.4.5-atmel/include/asm -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/lib/gcc-lib/mips64el-linux/2.95.4/include -pipe  -DCONFIG_MIPS
-D__MIPS__ -EL -mabi=64 -mips4
-mlong64 -Wall -Wstrict-prototypes -E -o atmel352.i atmel352.c

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
