Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 01:22:43 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:17900 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133619AbWGIAWa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2006 01:22:30 +0100
Received: from lagash (88-106-172-167.dynamic.dsl.as9105.com [88.106.172.167])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1794D45C95; Sun,  9 Jul 2006 02:22:29 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FzN40-0004NZ-F8; Sun, 09 Jul 2006 01:22:20 +0100
Date:	Sun, 9 Jul 2006 01:22:20 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Print out TLB handler assembly
Message-ID: <20060709002220.GB4375@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this changes tlbex to print out the (.word) assembler code of
the synthesized handlers.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e1a8139..709280e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -5,7 +5,7 @@
  *
  * Synthesize TLB refill handlers at runtime.
  *
- * Copyright (C) 2004,2005 by Thiemo Seufer
+ * Copyright (C) 2004,2005,2006 by Thiemo Seufer
  * Copyright (C) 2005  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
  *
@@ -35,8 +35,6 @@ #include <asm/elf.h>
 #include <asm/smp.h>
 #include <asm/war.h>
 
-/* #define DEBUG_TLB */
-
 static __init int __attribute__((unused)) r45k_bvahwbug(void)
 {
 	/* XXX: We should probe for the presence of this bug, but we don't. */
@@ -728,6 +726,7 @@ static void __init build_r3000_tlb_refil
 {
 	long pgdc = (long)pgd_current;
 	u32 *p;
+	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	p = tlb_handler;
@@ -753,16 +752,15 @@ static void __init build_r3000_tlb_refil
 	if (p > tlb_handler + 32)
 		panic("TLB refill handler space exceeded");
 
-	printk("Synthesized TLB refill handler (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB refill handler (%u instructions).\n",
 	       (unsigned int)(p - tlb_handler));
-#ifdef DEBUG_TLB
-	{
-		int i;
 
-		for (i = 0; i < (p - tlb_handler); i++)
-			printk("%08x\n", tlb_handler[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - tlb_handler); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", tlb_handler[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 
 	memcpy((void *)ebase, tlb_handler, 0x80);
 }
@@ -1175,6 +1173,7 @@ static void __init build_r4000_tlb_refil
 	struct reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
+	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -1272,24 +1271,22 @@ #else /* CONFIG_64BIT */
 #endif /* CONFIG_64BIT */
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB refill handler (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB refill handler (%u instructions).\n",
 	       final_len);
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		f = final_handler;
+	f = final_handler;
 #ifdef CONFIG_64BIT
-		if (final_len > 32)
-			final_len = 64;
-		else
-			f = final_handler + 32;
+	if (final_len > 32)
+		final_len = 64;
+	else
+		f = final_handler + 32;
 #endif /* CONFIG_64BIT */
-		for (i = 0; i < final_len; i++)
-			printk("%08x\n", f[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < final_len; i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", f[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 
 	memcpy((void *)ebase, final_handler, 0x100);
 }
@@ -1522,6 +1519,7 @@ static void __init build_r3000_tlb_load_
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1541,17 +1539,15 @@ static void __init build_r3000_tlb_load_
 		panic("TLB load handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB load handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbl));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbl); i++)
-			printk("%08x\n", handle_tlbl[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbl); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbl[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 static void __init build_r3000_tlb_store_handler(void)
@@ -1559,6 +1555,7 @@ static void __init build_r3000_tlb_store
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1578,17 +1575,15 @@ static void __init build_r3000_tlb_store
 		panic("TLB store handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB store handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbs));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbs); i++)
-			printk("%08x\n", handle_tlbs[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbs); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbs[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 static void __init build_r3000_tlb_modify_handler(void)
@@ -1596,6 +1591,7 @@ static void __init build_r3000_tlb_modif
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1615,17 +1611,15 @@ static void __init build_r3000_tlb_modif
 		panic("TLB modify handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB modify handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbm));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbm); i++)
-			printk("%08x\n", handle_tlbm[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbm); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbm[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 /*
@@ -1677,6 +1671,7 @@ static void __init build_r4000_tlb_load_
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1704,17 +1699,15 @@ static void __init build_r4000_tlb_load_
 		panic("TLB load handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB load handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbl));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbl); i++)
-			printk("%08x\n", handle_tlbl[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbl); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbl[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 static void __init build_r4000_tlb_store_handler(void)
@@ -1722,6 +1715,7 @@ static void __init build_r4000_tlb_store
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1740,17 +1734,15 @@ static void __init build_r4000_tlb_store
 		panic("TLB store handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB store handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbs));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbs); i++)
-			printk("%08x\n", handle_tlbs[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbs); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbs[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 static void __init build_r4000_tlb_modify_handler(void)
@@ -1758,6 +1750,7 @@ static void __init build_r4000_tlb_modif
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1777,17 +1770,15 @@ static void __init build_r4000_tlb_modif
 		panic("TLB modify handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
+	printk(KERN_INFO
+	       "Synthesized TLB modify handler fastpath (%u instructions).\n",
 	       (unsigned int)(p - handle_tlbm));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbm); i++)
-			printk("%08x\n", handle_tlbm[i]);
-	}
-#endif
+	printk(KERN_DEBUG "\t.set push\n");
+	printk(KERN_DEBUG "\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbm); i++)
+		printk(KERN_DEBUG "\t.word 0x%08x\n", handle_tlbm[i]);
+	printk(KERN_DEBUG "\t.set pop\n");
 }
 
 void __init build_tlb_refill_handler(void)
