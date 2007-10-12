Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 07:43:41 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:37917 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025322AbXJLGnd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 07:43:33 +0100
Received: by nf-out-0910.google.com with SMTP id c10so687471nfd
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 23:43:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=ctZubtPKx7X2f7/2IZdnG6igVajjMFOOH7n3OmTI3XE=;
        b=gxYYjm4MMAB4gALpK9p4A78z4gwXcqT9MoJaEbT2TFpXhZXnzJKx7KDnw8T0GWyvRTQOsnWN3G8plQTpIQXi687+B8CW5YfNppUzp+wTMCtmSzC6qwkgbfIcpdwCc4Z4cVfZsbAH9SUdbPEqfoFjERHFnm72i7+NFKZNwIEM19Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=AJR+sW5kWbhefXh5FKe76jP6dx78Xg4f6NZZdeXhMyuWuFIZeydX74uMjl6vIzEsaAZtpnphootWQGf/h27Q/V4vrLt2pGfgm9s32oOxLqb+PJ8lkvS+Mtl6KJxkg90jWSR51Y78DfRf5jKOWSSR6fVifV3WNF+2bi9J7eLmMK4=
Received: by 10.86.71.1 with SMTP id t1mr2125740fga.1192171412698;
        Thu, 11 Oct 2007 23:43:32 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j12sm622619fkf.2007.10.11.23.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 23:43:31 -0700 (PDT)
Message-ID: <470F1775.7090807@gmail.com>
Date:	Fri, 12 Oct 2007 08:43:01 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] tlbex.c: cleanup debug code
References: <470F16B9.7030406@gmail.com>
In-Reply-To: <470F16B9.7030406@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16981
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
index 923515e..4775e4c 100644
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
@@ -1591,7 +1590,6 @@ static void __init build_r3000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1614,11 +1612,7 @@ static void __init build_r3000_tlb_load_handler(void)
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
@@ -1626,7 +1620,6 @@ static void __init build_r3000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1649,11 +1642,7 @@ static void __init build_r3000_tlb_store_handler(void)
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
@@ -1661,7 +1650,6 @@ static void __init build_r3000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1684,11 +1672,7 @@ static void __init build_r3000_tlb_modify_handler(void)
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
@@ -1741,7 +1725,6 @@ static void __init build_r4000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1774,11 +1757,7 @@ static void __init build_r4000_tlb_load_handler(void)
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
@@ -1786,7 +1765,6 @@ static void __init build_r4000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1810,11 +1788,7 @@ static void __init build_r4000_tlb_store_handler(void)
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
@@ -1822,7 +1796,6 @@ static void __init build_r4000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label *l = labels;
 	struct reloc *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1847,11 +1820,7 @@ static void __init build_r4000_tlb_modify_handler(void)
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
1.5.3.3
