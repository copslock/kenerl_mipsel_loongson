Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f71GaNJ07316
	for linux-mips-outgoing; Wed, 1 Aug 2001 09:36:23 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f71GaKV07312
	for <linux-mips@oss.sgi.com>; Wed, 1 Aug 2001 09:36:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA26736;
	Wed, 1 Aug 2001 18:35:27 +0200 (MET DST)
Date: Wed, 1 Aug 2001 18:35:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, "Steven J. Hill" <sjhill@cotw.com>
cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Horrible X and kernel crashes under mipsel RH7.1...
In-Reply-To: <3B66B5F3.79D6AAB8@cotw.com>
Message-ID: <Pine.GSO.3.96.1010801182224.19537G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 31 Jul 2001, Steven J. Hill wrote:

> root@localhost:/home/sjhill$ /usr/X11R6/bin/Xfbdev 
> __alloc_pages: 5-order allocation failed.
> __alloc_pages: 5-order allocation failed.
> Unable to handle kernel paging request at virtual address 00000000, epc == 00000
> 000, ra == 80167750
> Oops in fault.c:do_page_fault, line 172:
> $0 : 00000000 801f0000 b30003f0 000000bb
> $4 : 0000000c 0000006b 809d3bc0 00006b18
> $8 : 00000020 801658f0 801cbc98 801c5000
> $12: 00000001 00000040 00000003 81f6eea0
> $16: 801dbf18 801cbe60 00000001 801d60cc
> $20: 801d0a3c 809d3bc0 00000000 806e3620
> $24: 00000001 2ac99d90
> $28: 813f2000 813f3de0 00000000 80167750
> epc   : 00000000
> Status: b001f003
> Cause : 00000008
> Process Xfbdev (pid: 596, stackpage=813f2000)
> 
> ***************
> 
> The next one I printed out the memory usage as well as the attempt to run
> startx and xinit first. The page alloc messages aren't printed, but the
> kernel still dies a horrible death.

 The kernel actually commits suicide.  I don't know why it does, but it
looks like a temporary debugging hack.  With the following patch the
system might survive. 

 Next you might want to find why the null pointer dereference happens. 
The __alloc_pages errors suggest some code does not check for a null
pointer being returned.  A kernel code inspection around address
0x80167750 might reveal guilty code.

 Ralf, could you please apply the patch?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010730-die-0
diff -up --recursive --new-file linux.macro/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.macro/arch/mips/kernel/traps.c	Tue Jul 24 04:26:34 2001
+++ linux/arch/mips/kernel/traps.c	Wed Aug  1 16:12:42 2001
@@ -204,7 +204,6 @@ extern void __die(const char * str, stru
 	show_trace((unsigned int *) regs->regs[29]);
 	show_code((unsigned int *) regs->cp0_epc);
 	printk("\n");
-while(1);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
