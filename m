Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2003 16:47:12 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30177 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225218AbTEPPrK>; Fri, 16 May 2003 16:47:10 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA07646;
	Fri, 16 May 2003 17:47:58 +0200 (MET DST)
Date: Fri, 16 May 2003 17:47:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: 2.5.x on Indy r4600
In-Reply-To: <20030516145452.GJ27494@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1030516171048.6533K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 16 May 2003, Jan-Benedict Glaw wrote:

> $ mips-linux-objdump -p indy-kernel
> 
> indy-kernel:     file format elf32-tradbigmips
> 
> Program Header:
> 0x70000000 off    0x001c6000 vaddr 0x881c8000 paddr 0x881c8000 align 2**2
>          filesz 0x00000018 memsz 0x00000018 flags r--
>     LOAD off    0x00001000 vaddr 0x88002000 paddr 0x88002000 align 2**12
>          filesz 0x001a3b78 memsz 0x001a3b78 flags r-x
>     LOAD off    0x001a5000 vaddr 0x881a6000 paddr 0x881a6000 align 2**12
>          filesz 0x0001ec40 memsz 0x0001ec40 flags rw-
>     LOAD off    0x001c4000 vaddr 0x881c6000 paddr 0x881c6000 align 2**12
>          filesz 0x00018080 memsz 0x00054640 flags rwx
> private flags = 10001001: [abi=O32] [mips2] [not 32bitmode]

 Hmm, it looks reasonable and the end is indeed at 0x1dc07f (= 0x1c4000 +
0x18080 - 1).

> Elf file type is EXEC (Executable file)
> Entry point 0x881c8058
> There are 4 program headers, starting at offset 52
> 
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   REGINFO        0x1c6000 0x881c8000 0x881c8000 0x00018 0x00018 R   0x4
>   LOAD           0x001000 0x88002000 0x88002000 0x1a3b78 0x1a3b78 R E 0x1000
>   LOAD           0x1a5000 0x881a6000 0x881a6000 0x1ec40 0x1ec40 RW  0x1000
>   LOAD           0x1c4000 0x881c6000 0x881c6000 0x18080 0x54640 RWE 0x1000

 And this looks fine, too.

 But there is a notable difference to 2.4 kernels, at least these I
inspected.  There are three loadable segments as opposed to two for 2.4
and the boot loader may be unhappy about it, e.g. it may have a bug that
gets hit.  You might want to reduce the number of segments (by changing
section flags -- look for ".section" gas directives).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
