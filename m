Received:  by oss.sgi.com id <S553792AbRAPOgp>;
	Tue, 16 Jan 2001 06:36:45 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:28420 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553781AbRAPOg0>;
	Tue, 16 Jan 2001 06:36:26 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7F3AB820; Tue, 16 Jan 2001 15:35:48 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1F091F597; Tue, 16 Jan 2001 15:36:18 +0100 (CET)
Date:   Tue, 16 Jan 2001 15:36:18 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116153618.A1347@paradigm.rfc822.org>
References: <20010115181133.A2439@paradigm.rfc822.org> <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 15, 2001 at 10:21:27PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 15, 2001 at 10:21:27PM +0100, Maciej W. Rozycki wrote:
>  Thanks for a useful report.  I am the responsible person, it would seem,
> as I've rewritten the bootmem allocation code recently to make it
> consistent across all the subports and more flexible as well.  I could 
> only test the DECstation code so it's possible I screwed up things
> elsewhere.  I'll look at the code and I'll provide a patch, either a fix,
> if I am able to develop it immediately or some debugging code otherwise.
> 
>  As I see prink() works for you could you please also check and report the
> memory map as found by the kernel, i.e. the lines output after "Determined
> physical RAM map:", if any?  The code is executed very early, before an
> actual allocation takes place, so it should run regardless.

Ok - when i do this ...

Index: arch/mips/arc/memory.c
===================================================================
RCS file: /cvs/linux/arch/mips/arc/memory.c,v
retrieving revision 1.17
diff -u -r1.17 memory.c
--- arch/mips/arc/memory.c	2001/01/03 18:15:24	1.17
+++ arch/mips/arc/memory.c	2001/01/16 13:53:45
@@ -120,7 +120,7 @@
 		unsigned long base, size;
 		long type;
 
-		base = __pa(p->base << PAGE_SHIFT);	/* Fix up from KSEG0 */
+		base = p->base << PAGE_SHIFT;
 		size = p->pages << PAGE_SHIFT;
 		type = prom_memtype_classify(p->type);


I get further down the road with memory initialisation.

Also the pages no in zone(0) looks much saner:

Before:
	On node 0 totalpages: 589824
	zone(0): 589824 pages.


After:
	On node 0 totalpages: 65536
	zone(0): 65536 pages.

Later on it crashes with:

[...]

start_kernel, 541
start_kernel, 543
Calibrating system timer... 1250000 [250.00 MHz CPU]
Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 1004fc00 00000001 00000000
$4 : 88009cd8 00000000 00000008 00000000
$8 : 1004fc01 1000001f 0000000a 00000001
$12: 00000000 00000004 00000000 00000001
$16: 00000000 00000002 0000000a 880083d8
$20: 00000001 a8746f70 9fc5c2b4 00000000
$24: 00002590 00000001
$28: 88008000 88009cd8 00000001 88010118
epc   : 880127b0
Status: 1004fc03
Cause : 10004000
Status: 1004fc03
Cause : 10004000
Cause : 10004000
Spinning...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
