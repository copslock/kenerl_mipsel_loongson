Received:  by oss.sgi.com id <S42275AbQFSJoB>;
	Mon, 19 Jun 2000 02:44:01 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:5063 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42234AbQFSJnk>;
	Mon, 19 Jun 2000 02:43:40 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA12007;
	Mon, 19 Jun 2000 11:31:28 +0200 (MET DST)
Date:   Mon, 19 Jun 2000 11:31:27 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Icache coherency problems for R3400, DS5000/240
Message-ID: <Pine.GSO.3.96.1000619110632.10348D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

 Working on gdb I discovered a weird behaviour of my DS5000/240 -- under
unspecified circumstances there were spurious breakpoint traps happening
and some single-step breakpoints appeared persistent.  The following patch
fixes these problems, making gdb fully reliable.

 Besides obvious bugfixes, it introduces two significant changes.  First,
flush_icache_page() now performs what the name suggests, i.e. flushes the
instruction cache.  Without this change ptrace(PTRACE_POKE*, ...) calls
are unreliable.  Second, it changes the assumption of the icache line size
to a single word -- apparently, at least R3400 of DS5000/240 has an icache
with such a layout (DEC docs confirm it, indeed).  Without this change,
there are problems with breakpoints placed at addresses equal 4 modulo 8. 

 I vote for an immediate inclusion of these fixes.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.3.99-pre8-20000523.macro/arch/mips/mm/r2300.c linux-mips-2.3.99-pre8-20000523/arch/mips/mm/r2300.c
--- linux-mips-2.3.99-pre8-20000523.macro/arch/mips/mm/r2300.c	Tue Mar 28 04:26:12 2000
+++ linux-mips-2.3.99-pre8-20000523/arch/mips/mm/r2300.c	Sun Jun 18 02:08:39 2000
@@ -151,15 +151,15 @@
 
 static void __init probe_dcache(void)
 {
-	dcache_size = r3k_cache_size(ST0_DE);
+	dcache_size = r3k_cache_size(ST0_ISC);
 	printk("Primary data cache %dkb, linesize 4 bytes\n",
 		dcache_size >> 10);
 }
 
 static void __init probe_icache(void)
 {
-	icache_size = r3k_cache_size(ST0_DE|ST0_CE);
-	printk("Primary instruction cache %dkb, linesize 8 bytes\n",
+	icache_size = r3k_cache_size(ST0_ISC|ST0_SWC);
+	printk("Primary instruction cache %dkb, linesize 4 bytes\n",
 		icache_size >> 10);
 }
 
@@ -174,43 +174,43 @@
 	save_and_cli(flags);
 
 	/* isolate cache space */
-	write_32bit_cp0_register(CP0_STATUS, (ST0_DE|ST0_CE|flags)&~ST0_IEC);
+	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
 
-	for (i = 0; i < size; i += 0x100) {
+	for (i = 0; i < size; i += 0x080) {
 		asm ( 	"sb\t$0,0x000(%0)\n\t"
+			"sb\t$0,0x004(%0)\n\t"
 			"sb\t$0,0x008(%0)\n\t"
+			"sb\t$0,0x00c(%0)\n\t"
 			"sb\t$0,0x010(%0)\n\t"
+			"sb\t$0,0x014(%0)\n\t"
 			"sb\t$0,0x018(%0)\n\t"
-			"sb\t$0,0x020(%0)\n\t"
+			"sb\t$0,0x01c(%0)\n\t"
+		 	"sb\t$0,0x020(%0)\n\t"
+			"sb\t$0,0x024(%0)\n\t"
 			"sb\t$0,0x028(%0)\n\t"
+			"sb\t$0,0x02c(%0)\n\t"
 			"sb\t$0,0x030(%0)\n\t"
+			"sb\t$0,0x034(%0)\n\t"
 			"sb\t$0,0x038(%0)\n\t"
-		 	"sb\t$0,0x040(%0)\n\t"
+			"sb\t$0,0x03c(%0)\n\t"
+			"sb\t$0,0x040(%0)\n\t"
+			"sb\t$0,0x044(%0)\n\t"
 			"sb\t$0,0x048(%0)\n\t"
+			"sb\t$0,0x04c(%0)\n\t"
 			"sb\t$0,0x050(%0)\n\t"
+			"sb\t$0,0x054(%0)\n\t"
 			"sb\t$0,0x058(%0)\n\t"
-			"sb\t$0,0x060(%0)\n\t"
+			"sb\t$0,0x05c(%0)\n\t"
+		 	"sb\t$0,0x060(%0)\n\t"
+			"sb\t$0,0x064(%0)\n\t"
 			"sb\t$0,0x068(%0)\n\t"
+			"sb\t$0,0x06c(%0)\n\t"
 			"sb\t$0,0x070(%0)\n\t"
+			"sb\t$0,0x074(%0)\n\t"
 			"sb\t$0,0x078(%0)\n\t"
-			"sb\t$0,0x080(%0)\n\t"
-			"sb\t$0,0x088(%0)\n\t"
-			"sb\t$0,0x090(%0)\n\t"
-			"sb\t$0,0x098(%0)\n\t"
-			"sb\t$0,0x0a0(%0)\n\t"
-			"sb\t$0,0x0a8(%0)\n\t"
-			"sb\t$0,0x0b0(%0)\n\t"
-			"sb\t$0,0x0b8(%0)\n\t"
-		 	"sb\t$0,0x0c0(%0)\n\t"
-			"sb\t$0,0x0c8(%0)\n\t"
-			"sb\t$0,0x0d0(%0)\n\t"
-			"sb\t$0,0x0d8(%0)\n\t"
-			"sb\t$0,0x0e0(%0)\n\t"
-			"sb\t$0,0x0e8(%0)\n\t"
-			"sb\t$0,0x0f0(%0)\n\t"
-			"sb\t$0,0x0f8(%0)\n\t"
+			"sb\t$0,0x07c(%0)\n\t"
 			: : "r" (p) );
-		p += 0x100;
+		p += 0x080;
 	}
 
 	restore_flags(flags);
@@ -221,13 +221,13 @@
 	unsigned long i, flags;
 	volatile unsigned char *p = (char *)start;
 
-	if (size > icache_size)
-		size = icache_size;
+	if (size > dcache_size)
+		size = dcache_size;
 
 	save_and_cli(flags);
 
 	/* isolate cache space */
-	write_32bit_cp0_register(CP0_STATUS, (ST0_DE|flags)&~ST0_IEC);
+	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|flags)&~ST0_IEC);
 
 	for (i = 0; i < size; i += 0x080) {
 		asm ( 	"sb\t$0,0x000(%0)\n\t"
@@ -376,7 +376,7 @@
 
 	save_and_cli(flags);
 
-	write_32bit_cp0_register(CP0_STATUS, (ST0_DE|ST0_CE|flags)&~ST0_IEC);
+	write_32bit_cp0_register(CP0_STATUS, (ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
 
 	asm ( 	"sb\t$0,0x000(%0)\n\t"
 		"sb\t$0,0x008(%0)\n\t"
diff -u --recursive --new-file linux-mips-2.3.99-pre8-20000523.macro/include/asm-mips/mipsregs.h linux-mips-2.3.99-pre8-20000523/include/asm-mips/mipsregs.h
--- linux-mips-2.3.99-pre8-20000523.macro/include/asm-mips/mipsregs.h	Sat May 27 01:49:02 2000
+++ linux-mips-2.3.99-pre8-20000523/include/asm-mips/mipsregs.h	Sun Jun 18 02:18:51 2000
@@ -234,6 +234,8 @@
 #define ST0_UX			0x00000020
 #define ST0_SX			0x00000040
 #define ST0_KX 			0x00000080
+#define ST0_DE			0x00010000
+#define ST0_CE			0x00020000
 
 /*
  * Bitfields in the R[23]000 cp0 status register.
@@ -245,6 +247,8 @@
 #define ST0_IEO			0x00000010
 #define ST0_KUO			0x00000020
 /* bits 6 & 7 are reserved on R[23]000 */
+#define ST0_ISC			0x00010000
+#define ST0_SWC			0x00020000
 
 /*
  * Bits specific to the R4640/R4650
@@ -273,8 +277,6 @@
 #define  STATUSF_IP6		(1   << 14)
 #define  STATUSB_IP7		15
 #define  STATUSF_IP7		(1   << 15)
-#define ST0_DE			0x00010000
-#define ST0_CE			0x00020000
 #define ST0_CH			0x00040000
 #define ST0_SR			0x00100000
 #define ST0_BEV			0x00400000
diff -u --recursive --new-file linux-mips-2.3.99-pre8-20000523.macro/include/asm-mips/pgtable.h linux-mips-2.3.99-pre8-20000523/include/asm-mips/pgtable.h
--- linux-mips-2.3.99-pre8-20000523.macro/include/asm-mips/pgtable.h	Tue Jun  6 23:21:21 2000
+++ linux-mips-2.3.99-pre8-20000523/include/asm-mips/pgtable.h	Sat Jun 17 19:35:42 2000
@@ -43,7 +43,7 @@
 #define flush_page_to_ram(page)		_flush_page_to_ram(page)
 
 #define flush_icache_range(start, end)	flush_cache_all()
-#define flush_icache_page(start,page)	do { } while(0)
+#define flush_icache_page(start,page)	flush_cache_all()
 
 
 /*
