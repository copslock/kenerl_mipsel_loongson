Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 06:01:34 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:50845 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492006Ab0GSEAk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jul 2010 06:00:40 +0200
Received: from localhost.localdomain (87-194-206-159.bethere.co.uk [87.194.206.159])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 3F2441B4008;
        Mon, 19 Jul 2010 04:00:38 +0000 (UTC)
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Ricardo Mendoza <ricmm@gentoo.org>
Subject: [PATCH 2/2] MIPS: RM7000: Add support for tertiary cache
Date:   Mon, 19 Jul 2010 05:00:00 +0100
Message-Id: <1279512000-9154-3-git-send-email-ricmm@gentoo.org>
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1279512000-9154-2-git-send-email-ricmm@gentoo.org>
References: <1279512000-9154-1-git-send-email-ricmm@gentoo.org>
 <1279512000-9154-2-git-send-email-ricmm@gentoo.org>
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

This adds support for the external tcache interface. Allows for platform
independent size probing from 512KB to 8MB in powers of two.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 arch/mips/include/asm/cacheops.h |    2 +
 arch/mips/mm/sc-rm7k.c           |  151 ++++++++++++++++++++++++++++++++------
 2 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index 256ad2c..4ca68da 100644
--- a/arch/mips/include/asm/cacheops.h
+++ b/arch/mips/include/asm/cacheops.h
@@ -62,6 +62,8 @@
  * RM7000-specific cacheops
  */
 #define Page_Invalidate_T	0x16
+#define Index_Store_Tag_T      0x0A
+#define Index_Load_Tag_T       0x06
 
 /*
  * R10000-specific cacheops
diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index 85678c4..5b33352 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -16,6 +16,7 @@
 #include <asm/cacheops.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
+#include <asm/sections.h>
 #include <asm/cacheflush.h> /* for run_uncached() */
 
 /* Primary cache parameters. */
@@ -25,11 +26,15 @@
 /* Secondary cache parameters. */
 #define scache_size	(256*1024)	/* Fixed to 256KiB on RM7000 */
 
+/* Tertiary cache parameters */
+#define tc_lsize	32
+
 extern unsigned long icache_way_size, dcache_way_size;
+unsigned long tcache_size;
 
 #include <asm/r4kcache.h>
 
-static int rm7k_tcache_enabled;
+static int rm7k_tcache_init;
 
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
@@ -46,7 +51,7 @@ static void rm7k_sc_wback_inv(unsigned long addr, unsigned long size)
 
 	blast_scache_range(addr, addr + size);
 
-	if (!rm7k_tcache_enabled)
+	if (!rm7k_tcache_init)
 		return;
 
 	a = addr & ~(tc_pagesize - 1);
@@ -70,7 +75,7 @@ static void rm7k_sc_inv(unsigned long addr, unsigned long size)
 
 	blast_inv_scache_range(addr, addr + size);
 
-	if (!rm7k_tcache_enabled)
+	if (!rm7k_tcache_init)
 		return;
 
 	a = addr & ~(tc_pagesize - 1);
@@ -83,6 +88,45 @@ static void rm7k_sc_inv(unsigned long addr, unsigned long size)
 	}
 }
 
+static void blast_rm7k_tcache(void)
+{
+	unsigned long start = CKSEG0ADDR(0);
+	unsigned long end = start + tcache_size;
+
+	write_c0_taglo(0);
+
+	while (start < end) {
+		cache_op(Page_Invalidate_T, start);
+		start += tc_pagesize;
+	}
+}
+
+/*
+ * This function is executed in uncached address space.
+ */
+static __cpuinit void __rm7k_tc_enable(void)
+{
+	int i;
+
+	set_c0_config(RM7K_CONF_TE);
+
+	write_c0_taglo(0);
+	write_c0_taghi(0);
+
+	for (i = 0; i < tcache_size; i += tc_lsize)
+		cache_op(Index_Store_Tag_T, CKSEG0ADDR(i));
+}
+
+static __cpuinit void rm7k_tc_enable(void)
+{
+	if (read_c0_config() & RM7K_CONF_TE)
+		return;
+
+	BUG_ON(tcache_size == 0);
+
+	run_uncached(__rm7k_tc_enable);
+}
+
 /*
  * This function is executed in uncached address space.
  */
@@ -106,11 +150,27 @@ static __cpuinit void rm7k_sc_enable(void)
 
 	printk(KERN_INFO "Enabling secondary cache...\n");
 	run_uncached(__rm7k_sc_enable);
+
+	if (rm7k_tcache_init)
+		rm7k_tc_enable();
+}
+
+static void rm7k_tc_disable(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	blast_rm7k_tcache();
+	clear_c0_config(RM7K_CONF_TE);
+	local_irq_save(flags);
 }
 
 static void rm7k_sc_disable(void)
 {
 	clear_c0_config(RM7K_CONF_SE);
+
+	if (rm7k_tcache_init)
+		rm7k_tc_disable();
 }
 
 static struct bcache_ops rm7k_sc_ops = {
@@ -120,6 +180,52 @@ static struct bcache_ops rm7k_sc_ops = {
 	.bc_inv = rm7k_sc_inv
 };
 
+/*
+ * This is a probing function like the one found in c-r4k.c, we look for the
+ * wrap around point with different addresses.
+ */
+static __cpuinit void __probe_tcache(void)
+{
+	unsigned long flags, addr, begin, end, pow2;
+
+	begin = (unsigned long) &_stext;
+	begin  &= ~((8 * 1024 * 1024) - 1);
+	end = begin + (8 * 1024 * 1024);
+
+	local_irq_save(flags);
+
+	set_c0_config(RM7K_CONF_TE);
+
+	/* Fill size-multiple lines with a valid tag */
+	pow2 = (256 * 1024);
+	for (addr = begin; addr <= end; addr = (begin + pow2)) {
+		unsigned long *p = (unsigned long *) addr;
+		__asm__ __volatile__("nop" : : "r" (*p));
+		pow2 <<= 1;
+	}
+
+	/* Load first line with a 0 tag, to check after */
+	write_c0_taglo(0);
+	write_c0_taghi(0);
+	cache_op(Index_Store_Tag_T, begin);
+
+	/* Look for the wrap-around */
+	pow2 = (512 * 1024);
+	for (addr = begin + (512 * 1024); addr <= end; addr = begin + pow2) {
+		cache_op(Index_Load_Tag_T, addr);
+		if (!read_c0_taglo())
+			break;
+		pow2 <<= 1;
+	}
+
+	addr -= begin;
+	tcache_size = addr;
+
+	clear_c0_config(RM7K_CONF_TE);
+
+	local_irq_restore(flags);
+}
+
 void __cpuinit rm7k_sc_init(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -139,27 +245,26 @@ void __cpuinit rm7k_sc_init(void)
 	if (!(config & RM7K_CONF_SE))
 		rm7k_sc_enable();
 
+	bcops = &rm7k_sc_ops;
+
 	/*
 	 * While we're at it let's deal with the tertiary cache.
 	 */
-	if (!(config & RM7K_CONF_TC)) {
-
-		/*
-		 * We can't enable the L3 cache yet. There may be board-specific
-		 * magic necessary to turn it on, and blindly asking the CPU to
-		 * start using it would may give cache errors.
-		 *
-		 * Also, board-specific knowledge may allow us to use the
-		 * CACHE Flash_Invalidate_T instruction if the tag RAM supports
-		 * it, and may specify the size of the L3 cache so we don't have
-		 * to probe it.
-		 */
-		printk(KERN_INFO "Tertiary cache present, %s enabled\n",
-		       (config & RM7K_CONF_TE) ? "already" : "not (yet)");
-
-		if ((config & RM7K_CONF_TE))
-			rm7k_tcache_enabled = 1;
-	}
 
-	bcops = &rm7k_sc_ops;
+	rm7k_tcache_init = 0;
+	tcache_size = 0;
+
+	if (config & RM7K_CONF_TC)
+		return;
+
+	/*
+	 * No efficient way to ask the hardware for the size of the tcache,
+	 * so must probe for it.
+	 */
+	run_uncached(__probe_tcache);
+	rm7k_tc_enable();
+	rm7k_tcache_init = 1;
+	c->tcache.linesz = tc_lsize;
+	c->tcache.ways = 1;
+	printk(KERN_INFO "Tertiary cache size %ldK.\n", (tcache_size >> 10));
 }
-- 
1.6.4.4
