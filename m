Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 01:47:27 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:58500 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133624AbWGIArQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2006 01:47:16 +0100
Received: from lagash (88-106-172-167.dynamic.dsl.as9105.com [88.106.172.167])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 4C3D145CCF; Sun,  9 Jul 2006 02:47:15 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FzNRy-0004QV-6d; Sun, 09 Jul 2006 01:47:06 +0100
Date:	Sun, 9 Jul 2006 01:47:06 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Print out TLB handler assembly
Message-ID: <20060709004706.GC4375@networkno.de>
References: <20060709002220.GB4375@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709002220.GB4375@networkno.de>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Hello All,
> 
> this changes tlbex to print out the (.word) assembler code of
> the synthesized handlers.

Small update, using pr_debug and pr_info.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e1a8139..375e099 100644
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
@@ -753,16 +752,14 @@ static void __init build_r3000_tlb_refil
 	if (p > tlb_handler + 32)
 		panic("TLB refill handler space exceeded");
 
-	printk("Synthesized TLB refill handler (%u instructions).\n",
-	       (unsigned int)(p - tlb_handler));
-#ifdef DEBUG_TLB
-	{
-		int i;
+	pr_info("Synthesized TLB refill handler (%u instructions).\n",
+		(unsigned int)(p - tlb_handler));
 
-		for (i = 0; i < (p - tlb_handler); i++)
-			printk("%08x\n", tlb_handler[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - tlb_handler); i++)
+		pr_debug("\t.word 0x%08x\n", tlb_handler[i]);
+	pr_debug("\t.set pop\n");
 
 	memcpy((void *)ebase, tlb_handler, 0x80);
 }
@@ -1175,6 +1172,7 @@ static void __init build_r4000_tlb_refil
 	struct reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
+	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -1272,24 +1270,21 @@ #else /* CONFIG_64BIT */
 #endif /* CONFIG_64BIT */
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB refill handler (%u instructions).\n",
-	       final_len);
-
-#ifdef DEBUG_TLB
-	{
-		int i;
+	pr_info("Synthesized TLB refill handler (%u instructions).\n",
+		final_len);
 
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
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < final_len; i++)
+		pr_debug("\t.word 0x%08x\n", f[i]);
+	pr_debug("\t.set pop\n");
 
 	memcpy((void *)ebase, final_handler, 0x100);
 }
@@ -1522,6 +1517,7 @@ static void __init build_r3000_tlb_load_
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1541,17 +1537,14 @@ static void __init build_r3000_tlb_load_
 		panic("TLB load handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbl));
-
-#ifdef DEBUG_TLB
-	{
-		int i;
+	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbl));
 
-		for (i = 0; i < (p - handle_tlbl); i++)
-			printk("%08x\n", handle_tlbl[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbl); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbl[i]);
+	pr_debug("\t.set pop\n");
 }
 
 static void __init build_r3000_tlb_store_handler(void)
@@ -1559,6 +1552,7 @@ static void __init build_r3000_tlb_store
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1578,17 +1572,14 @@ static void __init build_r3000_tlb_store
 		panic("TLB store handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbs));
+	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbs));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbs); i++)
-			printk("%08x\n", handle_tlbs[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbs); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbs[i]);
+	pr_debug("\t.set pop\n");
 }
 
 static void __init build_r3000_tlb_modify_handler(void)
@@ -1596,6 +1587,7 @@ static void __init build_r3000_tlb_modif
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1615,17 +1607,14 @@ static void __init build_r3000_tlb_modif
 		panic("TLB modify handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbm));
+	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbm));
 
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbm); i++)
-			printk("%08x\n", handle_tlbm[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbm); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbm[i]);
+	pr_debug("\t.set pop\n");
 }
 
 /*
@@ -1677,6 +1666,7 @@ static void __init build_r4000_tlb_load_
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1704,17 +1694,14 @@ static void __init build_r4000_tlb_load_
 		panic("TLB load handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB load handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbl));
-
-#ifdef DEBUG_TLB
-	{
-		int i;
+	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbl));
 
-		for (i = 0; i < (p - handle_tlbl); i++)
-			printk("%08x\n", handle_tlbl[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbl); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbl[i]);
+	pr_debug("\t.set pop\n");
 }
 
 static void __init build_r4000_tlb_store_handler(void)
@@ -1722,6 +1709,7 @@ static void __init build_r4000_tlb_store
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1740,17 +1728,14 @@ static void __init build_r4000_tlb_store
 		panic("TLB store handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB store handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbs));
-
-#ifdef DEBUG_TLB
-	{
-		int i;
+	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbs));
 
-		for (i = 0; i < (p - handle_tlbs); i++)
-			printk("%08x\n", handle_tlbs[i]);
-	}
-#endif
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbs); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbs[i]);
+	pr_debug("\t.set pop\n");
 }
 
 static void __init build_r4000_tlb_modify_handler(void)
@@ -1758,6 +1743,7 @@ static void __init build_r4000_tlb_modif
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
+	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1777,17 +1763,14 @@ static void __init build_r4000_tlb_modif
 		panic("TLB modify handler fastpath space exceeded");
 
 	resolve_relocs(relocs, labels);
-	printk("Synthesized TLB modify handler fastpath (%u instructions).\n",
-	       (unsigned int)(p - handle_tlbm));
-
-#ifdef DEBUG_TLB
-	{
-		int i;
-
-		for (i = 0; i < (p - handle_tlbm); i++)
-			printk("%08x\n", handle_tlbm[i]);
-	}
-#endif
+	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
+		(unsigned int)(p - handle_tlbm));
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+	for (i = 0; i < (p - handle_tlbm); i++)
+		pr_debug("\t.word 0x%08x\n", handle_tlbm[i]);
+	pr_debug("\t.set pop\n");
 }
 
 void __init build_tlb_refill_handler(void)
