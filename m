Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 08:13:33 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.227]:20853 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20025787AbXJRHNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 08:13:00 +0100
Received: by hu-out-0506.google.com with SMTP id 31so108749huc
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 00:12:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6A8gwSAtA8oFraHss/yxRGc39cbjjnNzyGGJ7972V4A=;
        b=ZiUEmR4ZBBiXuv3kNQ677qr9BCR5/nUprrZq5MuntxSWsaEuHI/06fCOEdcs9tw9pFCDCKmD6wpiEdgylQQiIUySA2mv1d5s952dELt0wV05Un7ryrkbV0xlHNQliE1mS8FkoItx1iqRAdY7ii1rPYbj7QNG8sp7aymuC/1twFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bh1FJTslPVFzR1PQD1sI5mp4MowV9k6rdW+kXibslYoShfAUxcqo+sJVRl8XfIzGD3EV8XGrjoYYeB7FCU4qprU38qNnejRcIYe0W8GOVnzvKkslcOQLLpijBC7HBav1F8ThUT++O64Txr9exhEciVBheakAvuJ/N9MKpkrmnUk=
Received: by 10.86.60.7 with SMTP id i7mr207967fga.1192691567555;
        Thu, 18 Oct 2007 00:12:47 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id f19sm816175fka.2007.10.18.00.12.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 00:12:46 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 4/4] tlbex.c: cleanup debug code
Date:	Thu, 18 Oct 2007 09:11:17 +0200
Message-Id: <1192691477-4675-5-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
References: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |   83 +++++++++++++++----------------------------------
 1 files changed, 26 insertions(+), 57 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index b6ef4b0..8a37077 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -705,6 +705,22 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
 	i_bgez(p, reg, 0);
 }
 
+/*
+ * For debug purposes.
+ */
+static inline void dump_handler(const u32 *handler, int count)
+{
+	int i;
+
+	pr_debug("\t.set push\n");
+	pr_debug("\t.set noreorder\n");
+
+	for (i = 0; i < count; i++)
+		pr_debug("\t%p\t.word 0x%08x\n", &handler[i], handler[i]);
+
+	pr_debug("\t.set pop\n");
+}
+
 /* The only general purpose registers allowed in TLB handlers. */
 #define K0		26
 #define K1		27
@@ -747,7 +763,6 @@ static void __init build_r3000_tlb_refill_handler(void)
 {
 	long pgdc = (long)pgd_current;
 	u32 *p;
-	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	p = tlb_handler;
@@ -776,13 +791,9 @@ static void __init build_r3000_tlb_refill_handler(void)
 	pr_info("Synthesized TLB refill handler (%u instructions).\n",
 		(unsigned int)(p - tlb_handler));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - tlb_handler); i++)
-		pr_debug("\t.word 0x%08x\n", tlb_handler[i]);
-	pr_debug("\t.set pop\n");
-
 	memcpy((void *)ebase, tlb_handler, 0x80);
+
+	dump_handler((u32 *)ebase, 32);
 }
 
 /*
@@ -1245,7 +1256,6 @@ static void __init build_r4000_tlb_refill_handler(void)
 	struct reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
-	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -1347,20 +1357,9 @@ static void __init build_r4000_tlb_refill_handler(void)
 	pr_info("Synthesized TLB refill handler (%u instructions).\n",
 		final_len);
 
-	f = final_handler;
-#if defined(CONFIG_64BIT) && !defined(CONFIG_CPU_LOONGSON2)
-	if (final_len > 32)
-		final_len = 64;
-	else
-		f = final_handler + 32;
-#endif /* CONFIG_64BIT */
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < final_len; i++)
-		pr_debug("\t.word 0x%08x\n", f[i]);
-	pr_debug("\t.set pop\n");
-
 	memcpy((void *)ebase, final_handler, 0x100);
+
+	dump_handler((u32 *)ebase, 64);
 }
 
 /*
@@ -1588,7 +1587,6 @@ static void __init build_r3000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1611,11 +1609,7 @@ static void __init build_r3000_tlb_load_handler(void)
 	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbl));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbl); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbl[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbl, ARRAY_SIZE(handle_tlbl));
 }
 
 static void __init build_r3000_tlb_store_handler(void)
@@ -1623,7 +1617,6 @@ static void __init build_r3000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1646,11 +1639,7 @@ static void __init build_r3000_tlb_store_handler(void)
 	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbs));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbs); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbs[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbs, ARRAY_SIZE(handle_tlbs));
 }
 
 static void __init build_r3000_tlb_modify_handler(void)
@@ -1658,7 +1647,6 @@ static void __init build_r3000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1681,11 +1669,7 @@ static void __init build_r3000_tlb_modify_handler(void)
 	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbm));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbm); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbm[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
 
 /*
@@ -1738,7 +1722,6 @@ static void __init build_r4000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1771,11 +1754,7 @@ static void __init build_r4000_tlb_load_handler(void)
 	pr_info("Synthesized TLB load handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbl));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbl); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbl[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbl, ARRAY_SIZE(handle_tlbl));
 }
 
 static void __init build_r4000_tlb_store_handler(void)
@@ -1783,7 +1762,6 @@ static void __init build_r4000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1807,11 +1785,7 @@ static void __init build_r4000_tlb_store_handler(void)
 	pr_info("Synthesized TLB store handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbs));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbs); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbs[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbs, ARRAY_SIZE(handle_tlbs));
 }
 
 static void __init build_r4000_tlb_modify_handler(void)
@@ -1819,7 +1793,6 @@ static void __init build_r4000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1844,11 +1817,7 @@ static void __init build_r4000_tlb_modify_handler(void)
 	pr_info("Synthesized TLB modify handler fastpath (%u instructions).\n",
 		(unsigned int)(p - handle_tlbm));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - handle_tlbm); i++)
-		pr_debug("\t.word 0x%08x\n", handle_tlbm[i]);
-	pr_debug("\t.set pop\n");
+	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
 
 void __init build_tlb_refill_handler(void)
-- 
1.5.3.4
