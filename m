Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 02:57:57 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:20745
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225205AbTFPB5z>; Mon, 16 Jun 2003 02:57:55 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 16 Jun 2003 01:57:53 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h5G1vfiY019512;
	Mon, 16 Jun 2003 10:57:41 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Mon, 16 Jun 2003 10:58:39 +0900 (JST)
Message-Id: <20030616.105839.71082782.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030616.104224.92590182.nemoto@toshiba-tops.co.jp>
References: <20030615004718Z8225220-1272+2582@linux-mips.org>
	<20030616.101911.07647456.nemoto@toshiba-tops.co.jp>
	<20030616.104224.92590182.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 16 Jun 2003 10:42:24 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
>>>>> On Mon, 16 Jun 2003 10:19:11 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
>>>>> On Sun, 15 Jun 2003 01:47:13 +0100, ralf@linux-mips.org said:
>>> Modified files:
>>> arch/mips64    : Tag: linux_2_4 Makefile 
>>> include/asm-mips64: Tag: linux_2_4 processor.h r4kcache.h 

>>> Log message:
>>> Support GT64120 boards with 64-bit kernels also.

nemoto> This corrupts mips64/mm/c-r4k.c.  Please apply this patch also.

nemoto> And I doubt that 'unsigned short' is enough for the 'waysize'
nemoto> (especially for scache).  How about this?

Then this is a patch to sync 32-bit version.

diff -ur linux-mips-cvs/arch/mips/mm/c-r4k.c linux.new/arch/mips/mm/c-r4k.c
--- linux-mips-cvs/arch/mips/mm/c-r4k.c	Mon Apr 28 09:44:52 2003
+++ linux.new/arch/mips/mm/c-r4k.c	Mon Jun 16 10:43:21 2003
@@ -26,7 +26,6 @@
 
 /* Primary cache parameters. */
 static unsigned long icache_size, dcache_size, scache_size;
-unsigned long icache_way_size, dcache_way_size, scache_way_size;
 static unsigned long scache_size;
 
 #include <asm/cacheops.h>
@@ -848,8 +847,8 @@
 		panic("Improper R4000SC processor configuration detected");
 
 	/* compute a couple of other cache variables */
-	icache_way_size = icache_size / c->icache.ways;
-	dcache_way_size = dcache_size / c->dcache.ways;
+	c->icache.waysize = icache_size / c->icache.ways;
+	c->dcache.waysize = dcache_size / c->dcache.ways;
 
 	c->icache.sets = icache_size / (c->icache.linesz * c->icache.ways);
 	c->dcache.sets = dcache_size / (c->dcache.linesz * c->dcache.ways);
@@ -862,7 +861,7 @@
 	 */
 	if (current_cpu_data.cputype != CPU_R10000 &&
 	    current_cpu_data.cputype != CPU_R12000)
-		if (dcache_way_size > PAGE_SIZE)
+		if (c->dcache.waysize > PAGE_SIZE)
 		        c->dcache.flags |= MIPS_CACHE_ALIASES;
 
 	if (config & 0x8)		/* VI bit */
diff -ur linux-mips-cvs/arch/mips/mm/c-tx39.c linux.new/arch/mips/mm/c-tx39.c
--- linux-mips-cvs/arch/mips/mm/c-tx39.c	Tue May  6 09:40:58 2003
+++ linux.new/arch/mips/mm/c-tx39.c	Mon Jun 16 10:46:54 2003
@@ -25,9 +25,7 @@
 
 /* For R3000 cores with R4000 style caches */
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
-static unsigned long icache_way_size, dcache_way_size;	/* Size divided by ways */
 #define scache_size 0
-#define scache_way_size 0
 
 #include <asm/r4kcache.h>
 
@@ -473,15 +471,15 @@
 		break;
 	}
 
-	icache_way_size = icache_size / current_cpu_data.icache.ways;
-	dcache_way_size = dcache_size / current_cpu_data.dcache.ways;
+	current_cpu_data.icache.waysize = icache_size / current_cpu_data.icache.ways;
+	current_cpu_data.dcache.waysize = dcache_size / current_cpu_data.dcache.ways;
 
 	current_cpu_data.icache.sets =
-		icache_way_size / current_cpu_data.icache.linesz;
+		current_cpu_data.icache.waysize / current_cpu_data.icache.linesz;
 	current_cpu_data.dcache.sets =
-		dcache_way_size / current_cpu_data.dcache.linesz;
+		current_cpu_data.dcache.waysize / current_cpu_data.dcache.linesz;
 
-	if (dcache_way_size > PAGE_SIZE)
+	if (current_cpu_data.dcache.waysize > PAGE_SIZE)
 		current_cpu_data.dcache.flags |= MIPS_CACHE_ALIASES;
 
 	current_cpu_data.icache.waybit = 0;
diff -ur linux-mips-cvs/arch/mips/mm/sc-rm7k.c linux.new/arch/mips/mm/sc-rm7k.c
--- linux-mips-cvs/arch/mips/mm/sc-rm7k.c	Fri Apr 18 10:23:03 2003
+++ linux.new/arch/mips/mm/sc-rm7k.c	Mon Jun 16 10:44:02 2003
@@ -20,8 +20,6 @@
 /* Secondary cache parameters. */
 #define scache_size	(256*1024)	/* Fixed to 256KiB on RM7000 */
 
-extern unsigned long icache_way_size, dcache_way_size;
-
 #include <asm/r4kcache.h>
 
 int rm7k_tcache_enabled;
diff -ur linux-mips-cvs/include/asm-mips/processor.h linux.new/include/asm-mips/processor.h
--- linux-mips-cvs/include/asm-mips/processor.h	Thu May  8 10:28:23 2003
+++ linux.new/include/asm-mips/processor.h	Mon Jun 16 10:43:04 2003
@@ -34,11 +34,12 @@
  * Descriptor for a cache
  */
 struct cache_desc {
-	unsigned short linesz;
-	unsigned short ways;
-	unsigned int sets;
-	unsigned int waybit;	/* Bits to select in a cache set */
-	unsigned int flags;	/* Flags describingcache properties */
+	unsigned short linesz;	/* Size of line in bytes */
+	unsigned short ways;	/* Number of ways */
+	unsigned short sets;	/* Number of lines per set */
+	unsigned short waybit;	/* Bits to select in a cache set */
+	unsigned int waysize;	/* Bytes per way */
+	unsigned int flags;	/* Flags describing cache properties */
 };
 
 /*
diff -ur linux-mips-cvs/include/asm-mips/r4kcache.h linux.new/include/asm-mips/r4kcache.h
--- linux-mips-cvs/include/asm-mips/r4kcache.h	Mon Apr 28 09:44:57 2003
+++ linux.new/include/asm-mips/r4kcache.h	Mon Jun 16 10:42:51 2003
@@ -140,7 +140,7 @@
 static inline void blast_dcache16(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + dcache_way_size;
+	unsigned long end = start + current_cpu_data.dcache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
 	unsigned long ws_end = current_cpu_data.dcache.ways << 
 	                       current_cpu_data.dcache.waybit;
@@ -179,7 +179,7 @@
 static inline void blast_icache16(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + icache_way_size;
+	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
 	                       current_cpu_data.icache.waybit;
@@ -218,7 +218,7 @@
 static inline void blast_scache16(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + scache_way_size;
+	unsigned long end = start + current_cpu_data.scache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
 	unsigned long ws_end = current_cpu_data.scache.ways << 
 	                       current_cpu_data.scache.waybit;
@@ -283,7 +283,7 @@
 static inline void blast_dcache32(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + dcache_way_size;
+	unsigned long end = start + current_cpu_data.dcache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.dcache.waybit;
 	unsigned long ws_end = current_cpu_data.dcache.ways <<
 	                       current_cpu_data.dcache.waybit;
@@ -322,7 +322,7 @@
 static inline void blast_icache32(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + icache_way_size;
+	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
 	                       current_cpu_data.icache.waybit;
@@ -361,7 +361,7 @@
 static inline void blast_scache32(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + scache_way_size;
+	unsigned long end = start + current_cpu_data.scache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
 	unsigned long ws_end = current_cpu_data.scache.ways << 
 	                       current_cpu_data.scache.waybit;
@@ -426,7 +426,7 @@
 static inline void blast_icache64(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + icache_way_size;
+	unsigned long end = start + current_cpu_data.icache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
 	                       current_cpu_data.icache.waybit;
@@ -465,7 +465,7 @@
 static inline void blast_scache64(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + scache_way_size;
+	unsigned long end = start + current_cpu_data.scache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
 	unsigned long ws_end = current_cpu_data.scache.ways << 
 	                       current_cpu_data.scache.waybit;
@@ -530,7 +530,7 @@
 static inline void blast_scache128(void)
 {
 	unsigned long start = KSEG0;
-	unsigned long end = start + scache_way_size;
+	unsigned long end = start + current_cpu_data.scache.waysize;
 	unsigned long ws_inc = 1UL << current_cpu_data.scache.waybit;
 	unsigned long ws_end = current_cpu_data.scache.ways << 
 	                       current_cpu_data.scache.waybit;
---
Atsushi Nemoto
