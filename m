Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 14:26:19 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:32523
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225229AbTHAN0O>; Fri, 1 Aug 2003 14:26:14 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 1 Aug 2003 13:26:12 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h71DPrDV076992;
	Fri, 1 Aug 2003 22:25:54 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 01 Aug 2003 22:27:12 +0900 (JST)
Message-Id: <20030801.222712.123927329.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: End c-tx49.c's misserable existence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030414.123514.74756574.nemoto@toshiba-tops.co.jp>
References: <20030412163215Z8225197-1272+1264@linux-mips.org>
	<20030414.123514.74756574.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 14 Apr 2003 12:35:14 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> TOSHIBA_ICACHE_WAR can be removed.  This workaround is not
anemo> needed if kernel does not modify the cache codes itself in
anemo> run-time.

anemo> When I wrote c-tx49.c I blindly followed the statement in
anemo> TX49/H2 manual's statement. ("If the instruction (i.e. CACHE)
anemo> is issued for the line which this instruction itself exists,
anemo> the following operation is not guaranteed.")  Now I know this
anemo> warning is only for self-modified code.  There must be no
anemo> problem if the codes is not modified in run-time.  So please
anemo> remove all TOSHIBA_ICACHE_WAR stuff and make c-r4k.c more
anemo> clean.

Very sorry, I was wrong (unfortunately).  TX49 does NOT work correctly
if CACHE instruction was issued for the line which the code exists
(even if the code was never modified in run-time).

I implemented the workaround again in another way (put the flushing
loop on an aligned place and do two phase flushing).  I did not use
"#ifdef" in c-r4k.c since gcc will be omit unnecessary codes
automatically.

This is a patch against 2.4 branch (mips version only.  mips64 is
same).  This also can be applied for 2.6 branch.  Please apply.


diff -ur linux-mips-cvs/arch/mips/mm/c-r4k.c linux.new/arch/mips/mm/c-r4k.c
--- linux-mips-cvs/arch/mips/mm/c-r4k.c	Fri Aug  1 22:03:00 2003
+++ linux.new/arch/mips/mm/c-r4k.c	Fri Aug  1 22:08:52 2003
@@ -149,6 +149,58 @@
 	goto *l;
 }
 
+/* force code alignment (used for TX49XX_ICACHE_INDEX_INV_WAR) */
+#define JUMP_TO_ALIGN(order) \
+	__asm__ __volatile__( \
+		"b\t1f\n\t" \
+		".align\t" #order "\n\t" \
+		"1:\n\t" \
+		)
+#define CACHE32_UNROLL32_ALIGN	JUMP_TO_ALIGN(10) /* 32 * 32 = 1024 */
+#define CACHE32_UNROLL32_ALIGN2	JUMP_TO_ALIGN(11)
+
+static inline void tx49_blast_icache32(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = start + current_cpu_data.icache.waysize;
+	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
+	unsigned long ws_end = current_cpu_data.icache.ways <<
+	                       current_cpu_data.icache.waybit;
+	unsigned long ws, addr;
+
+	CACHE32_UNROLL32_ALIGN2;
+	/* I'm in even chunk.  blast odd chunks */
+	for (ws = 0; ws < ws_end; ws += ws_inc) 
+		for (addr = start + 0x400; addr < end; addr += 0x400 * 2) 
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+	CACHE32_UNROLL32_ALIGN;
+	/* I'm in odd chunk.  blast even chunks */
+	for (ws = 0; ws < ws_end; ws += ws_inc) 
+		for (addr = start; addr < end; addr += 0x400 * 2) 
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+}
+
+static inline void tx49_blast_icache32_page_indexed(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = start + PAGE_SIZE;
+	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
+	unsigned long ws_end = current_cpu_data.icache.ways <<
+	                       current_cpu_data.icache.waybit;
+	unsigned long ws, addr;
+
+	CACHE32_UNROLL32_ALIGN2;
+	/* I'm in even chunk.  blast odd chunks */
+	for (ws = 0; ws < ws_end; ws += ws_inc) 
+		for (addr = start + 0x400; addr < end; addr += 0x400 * 2) 
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+	CACHE32_UNROLL32_ALIGN;
+	/* I'm in odd chunk.  blast even chunks */
+	for (ws = 0; ws < ws_end; ws += ws_inc) 
+		for (addr = start; addr < end; addr += 0x400 * 2) 
+			cache32_unroll32(addr|ws,Index_Invalidate_I);
+}
+
 static void r4k_blast_icache_page(unsigned long addr)
 {
 	unsigned long ic_lsize = current_cpu_data.icache.linesz;
@@ -197,11 +249,18 @@
 	blast_icache64_page_indexed(addr);
 	return;
 
+ic_32_tx49:
+	tx49_blast_icache32_page_indexed(addr);
+	return;
+
 init:
 	if (ic_lsize == 16)
 		l = &&ic_16;
 	else if (ic_lsize == 32)
-		l = &&ic_32;
+		if (TX49XX_ICACHE_INDEX_INV_WAR)
+			l = &&ic_32_tx49;
+		else
+			l = &&ic_32;
 	else if (ic_lsize == 64)
 		l = &&ic_64;
 	goto *l;
@@ -226,11 +285,18 @@
 	blast_icache64();
 	return;
 
+ic_32_tx49:
+	tx49_blast_icache32();
+	return;
+
 init:
 	if (ic_lsize == 16)
 		l = &&ic_16;
 	else if (ic_lsize == 32)
-		l = &&ic_32;
+		if (TX49XX_ICACHE_INDEX_INV_WAR)
+			l = &&ic_32_tx49;
+		else
+			l = &&ic_32;
 	else if (ic_lsize == 64)
 		l = &&ic_64;
 	goto *l;
diff -ur linux-mips-cvs/include/asm-mips/war.h linux.new/include/asm-mips/war.h
--- linux-mips-cvs/include/asm-mips/war.h	Fri Aug  1 22:01:30 2003
+++ linux.new/include/asm-mips/war.h	Fri Aug  1 21:53:39 2003
@@ -148,6 +148,17 @@
 #endif
 
 /*
+ * From TX49/H2 manual: "If the instruction (i.e. CACHE) is issued for
+ * the line which this instruction itself exists, the following
+ * operation is not guaranteed."
+ *
+ * Workaround: do two phase flushing for Index_Invalidate_I
+ */
+#ifdef CONFIG_CPU_TX49XX
+#define TX49XX_ICACHE_INDEX_INV_WAR 1
+#endif
+
+/*
  * Workarounds default to off
  */
 #ifndef R4600_V1_HIT_CACHEOP_WAR
@@ -171,5 +182,8 @@
 #ifndef MIPS_CACHE_SYNC_WAR
 #define MIPS_CACHE_SYNC_WAR		0
 #endif
+#ifndef TX49XX_ICACHE_INDEX_INV_WAR
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#endif
 
 #endif /* _ASM_WAR_H */
---
Atsushi Nemoto
