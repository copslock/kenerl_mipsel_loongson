Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PBZx628391
	for linux-mips-outgoing; Mon, 25 Jun 2001 04:35:59 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PBZuV28382
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 04:35:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA21900;
	Mon, 25 Jun 2001 13:36:15 +0200 (MET DST)
Date: Mon, 25 Jun 2001 13:36:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] 2.4.5 and earlier: Mysterious lock-ups resolved
Message-ID: <Pine.GSO.3.96.1010625125007.20469D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 After extensive debugging I managed to track down the bug that was
preventing me from building binutils since the beginning of February.
Once again the culprit turned out to the the explicit nature of MIPS'
caches.

 The problem lies in r3k_flush_cache_sigtramp().  It flushes three
consecutive word-wide locations starting from the address passed as an
argument.  The argument is normally a sigreturn trampoline that is set up
by setup_frame() or setup_rt_frame().  But these functions set up two
opcodes only -- the third word is left untouched.  In my case the address
was something like 0x7???bff8.  So the area to be flushed spanned a page
boundary and since the third word was unreferenced, a TLB entry for the
page the word was located in was absent.  As a result, a TLB refill
exception happened with caches isolated, which is not necessarily a win.
The symptom was a solid crash. 

 I don't see any reason to flush the third word location, so I removed the
code doing it.  This fixed the crashes I was observing, but since we are
using mapped (KUSEG) addresses in r3k_flush_cache_sigtramp(), I believe we
need more protection against unwanted TLB exceptions.  The point is we are
running with interrupts enabled and a reschedule may happen between
touching the trampoline in setup*_frame() and flushing the cache.  Hence
the TLB entries for the trampoline area, even once present, may get
removed meanwhile.  So I added some code to explicitly load the entries,
if needed, with interrupts disabled just before isolating caches. 
Following is a resulting patch. 

 Ralf, this is a showstopper bug -- please apply the fix ASAP. 

 This was a tough problem to chase, indeed... 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010622-sigtramp-1
diff -up --recursive --new-file linux-mips-2.4.5-20010622.macro/arch/mips/mm/r2300.c linux-mips-2.4.5-20010622/arch/mips/mm/r2300.c
--- linux-mips-2.4.5-20010622.macro/arch/mips/mm/r2300.c	Mon Jun 11 04:26:13 2001
+++ linux-mips-2.4.5-20010622/arch/mips/mm/r2300.c	Mon Jun 25 09:07:42 2001
@@ -391,11 +391,17 @@ static void r3k_flush_cache_sigtramp(uns
 
 	flags = read_32bit_cp0_register(CP0_STATUS);
 
+	write_32bit_cp0_register(CP0_STATUS, flags&~ST0_IEC);
+
+	/* Fill the TLB to avoid an exception with caches isolated. */
+	asm ( 	"lw\t$0,0x000(%0)\n\t"
+		"lw\t$0,0x004(%0)\n\t"
+		: : "r" (addr) );
+
 	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
 
 	asm ( 	"sb\t$0,0x000(%0)\n\t"
 		"sb\t$0,0x004(%0)\n\t"
-		"sb\t$0,0x008(%0)\n\t"
 		: : "r" (addr) );
 
 	write_32bit_cp0_register(CP0_STATUS, flags);
