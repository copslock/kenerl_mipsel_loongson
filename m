Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:38:50 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:50953 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022234AbXJIUin (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:38:43 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1328077nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:38:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=jr/jAoD0826yLhobjZCssUIs8EEKQB0NIIsbmW9RvF4=;
        b=FQYGGcDbDRmpfxm7Nl52NQgsX2lDAbuU0SXccyFZREkY/Azpf1m+wFOmWpdY9/2fcb8IbAfg6Oj1BGSBacMFkXl1BSoUV9t+xW30aKKhpx3lH+A0F2qox0YjuzfOkl/7RNAM78PlBgQd3cW/s56l7ZN2j6FKKXpT62Os2dWY13U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=P07p1PbnT+Mat18Rr/SrdyR+App7P8alE0idvf3q8/k8cmfDmKonJ6DAkMMCasmhVrUX9eKz2uXJAD/59909SV3XteAgyYqsgmHFPzUb/2srdX/OU/dJH0z7e8cFHdzYp5iR1H1KBNrz5Yz3gF0TvAFOh55pG3TYZqwGuzebciI=
Received: by 10.86.81.8 with SMTP id e8mr6319409fgb.1191962322729;
        Tue, 09 Oct 2007 13:38:42 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 31sm8952681fkt.2007.10.09.13.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:38:41 -0700 (PDT)
Message-ID: <470BE6BF.7090405@gmail.com>
Date:	Tue, 09 Oct 2007 22:38:23 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 5/6] tlbex.c: cleanup debug code   
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com>
In-Reply-To: <470BE58A.9070709@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16917
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
index 6991b89..e725072 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -714,6 +714,22 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
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
@@ -749,7 +765,6 @@ static void __init build_r3000_tlb_refill_handler(void)
 {
 	u32 tlb_handler[64], *p = tlb_handler;
 	long pgdc = (long)pgd_current;
-	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 
@@ -777,13 +792,9 @@ static void __init build_r3000_tlb_refill_handler(void)
 	pr_info("Synthesized TLB refill handler (%u instructions).\n",
 		(unsigned int)(p - tlb_handler));
 
-	pr_debug("\t.set push\n");
-	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (p - tlb_handler); i++)
-		pr_debug("\t.word 0x%08x\n", tlb_handler[i]);
-	pr_debug("\t.set pop\n");
-
 	memcpy((void *)ebase, tlb_handler, 32);
+
+	dump_handler((u32 *)ebase, 32);
 }
 
 /*
@@ -1255,7 +1266,6 @@ static void __init build_r4000_tlb_refill_handler(void)
 	struct label labels[128], *l = labels;
 	struct reloc relocs[128], *r = relocs;
 	unsigned int final_len;
-	int i;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
@@ -1357,20 +1367,9 @@ static void __init build_r4000_tlb_refill_handler(void)
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
 	memcpy((void *)ebase, final_handler, 64);
+
+	dump_handler((u32 *)ebase, 64);
 }
 
 /*
@@ -1601,7 +1600,6 @@ static void __init build_r3000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1624,11 +1622,7 @@ static void __init build_r3000_tlb_load_handler(void)
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
@@ -1636,7 +1630,6 @@ static void __init build_r3000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1659,11 +1652,7 @@ static void __init build_r3000_tlb_store_handler(void)
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
@@ -1671,7 +1660,6 @@ static void __init build_r3000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1694,11 +1682,7 @@ static void __init build_r3000_tlb_modify_handler(void)
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
@@ -1751,7 +1735,6 @@ static void __init build_r4000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1784,11 +1767,7 @@ static void __init build_r4000_tlb_load_handler(void)
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
@@ -1796,7 +1775,6 @@ static void __init build_r4000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
@@ -1820,11 +1798,7 @@ static void __init build_r4000_tlb_store_handler(void)
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
@@ -1832,7 +1806,6 @@ static void __init build_r4000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct label labels[FASTPATH_SIZE], *l = labels;
 	struct reloc relocs[FASTPATH_SIZE], *r = relocs;
-	int i;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
@@ -1857,11 +1830,7 @@ static void __init build_r4000_tlb_modify_handler(void)
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
