Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:33:31 +0200 (CEST)
Received: from mail-pg1-x531.google.com ([IPv6:2607:f8b0:4864:20::531]:38766
        "EHLO mail-pg1-x531.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994565AbeIEJd2BIuiC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:33:28 +0200
Received: by mail-pg1-x531.google.com with SMTP id t84-v6so1306076pgb.5;
        Wed, 05 Sep 2018 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVj9a4z2XxSVo1cHK3HIQkU65uPO712CHDITKCEvtXs=;
        b=mEu9NEQpbn80bsiC2tF3Av8w6xnrXFLJXWj+BvWOsKawndxGIcB88uY2P1WDBYh2S2
         Wu207NcQ6isRzo8kAtRiXHZs4nu2hnIji1eGAEID68O5oDLibJIeTmXnLUuZ1h0MAiB7
         bu/UCEUEj5bXzps2o8mHjsUtjpvZivwwIb0leeLm1PdGpwxaXQ7qrUQUgXnZO+m21thP
         OGLb0K7wiCJgfzzUIxzEp0dHNAPNekoQ+xDDrRMLle/lr6aMiLd4xbJlaFnHXTe9KkT4
         AQTNDNO5RTnBfvndtQJ53xoACx75RfojfS+TehZQY3bBzlD+mhTmQW2Xs6A3h3Z3K0BJ
         Modg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=aVj9a4z2XxSVo1cHK3HIQkU65uPO712CHDITKCEvtXs=;
        b=hSp/ksgT4ugMTNfKpMrPp2nF1k/ZDKtdKyzoCkEEH4Tm1jFA2YmRpYAg5vZu2dKWtl
         r/Ajb9NkmHefOx1MRYj7Utv7btbuOquUEYzhoOd8rWfaQy6/Pa6y5MZiAC92UyjkJAR3
         TKJ6xUGdH/bA/SmUq4W+aaBiA22+3nQ16xKod/lTsDaVjsuDsD8W8QCgxQm3JPpwZO9z
         /dvfaKZ8pr/OCAdfstFr3Drkl3/roXN4y4vHwk76CGbqdvPUDfnHAiPdcFr8pBZRCJIZ
         BA7BOjw8ds2JyJVBqvSXgRl4OaejZU5vcjUC13I+svfplj64pSO05vKrKObr0uwlnotA
         qg5g==
X-Gm-Message-State: APzg51AbiJ9dkGKxiJedj8oARiMTbStE2Z173ZJpqJmsRnpnKK+owzb0
        e54bfbx0wHrOIU/fjt+CWnzjPvPoKbc=
X-Google-Smtp-Source: ANB0VdaJOyQc7v9RVXC5ICDiDkwYtXPkVkFUu2GXBqWx25AS9NSfFf2RyTMEg9K2s0ZRuQo682AwJA==
X-Received: by 2002:a62:c8d2:: with SMTP id i79-v6mr39225058pfk.35.1536140001527;
        Wed, 05 Sep 2018 02:33:21 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:33:20 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: [PATCH 02/10] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Wed,  5 Sep 2018 17:33:02 +0800
Message-Id: <1536139990-11665-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
only flush Node-0's scache. So we add r4k_blast_scache_node() by using
(CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
start address.

Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/mmzone.h |  1 +
 arch/mips/include/asm/mmzone.h                 |  8 +++++
 arch/mips/include/asm/r4kcache.h               | 25 +++++++++++++++
 arch/mips/mm/c-r4k.c                           | 44 ++++++++++++++++++++++----
 4 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index c9f7e23..59c8b11 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -21,6 +21,7 @@
 #define NODE3_ADDRSPACE_OFFSET 0x300000000000UL
 
 #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
+#define nid_to_addrbase(nid) ((nid) << NODE_ADDRSPACE_SHIFT)
 
 #define LEVELS_PER_SLICE 128
 
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index f085fba..2a0fe1d 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -9,6 +9,14 @@
 #include <asm/page.h>
 #include <mmzone.h>
 
+#ifndef pa_to_nid
+#define pa_to_nid(addr) 0
+#endif
+
+#ifndef nid_to_addrbase
+#define nid_to_addrbase(nid) 0
+#endif
+
 #ifdef CONFIG_DISCONTIGMEM
 
 #define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 7f12d7e..e3f70dc 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -747,4 +747,29 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
 __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
 
+/* Currently, this is very specific to Loongson-3 */
+#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\
+static inline void blast_##pfx##cache##lsize##_node(long node)		\
+{									\
+	unsigned long start = CAC_BASE | nid_to_addrbase(node);		\
+	unsigned long end = start + current_cpu_data.desc.waysize;	\
+	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
+	unsigned long ws_end = current_cpu_data.desc.ways <<		\
+			       current_cpu_data.desc.waybit;		\
+	unsigned long ws, addr;						\
+									\
+	__##pfx##flush_prologue						\
+									\
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws, indexop);	\
+									\
+	__##pfx##flush_epilogue						\
+}
+
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
+
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a9ef057..05a539d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -459,11 +459,28 @@ static void r4k_blast_scache_setup(void)
 		r4k_blast_scache = blast_scache128;
 }
 
+static void (*r4k_blast_scache_node)(long node);
+
+static void r4k_blast_scache_node_setup(void)
+{
+	unsigned long sc_lsize = cpu_scache_line_size();
+
+	if (current_cpu_type() != CPU_LOONGSON3)
+		r4k_blast_scache_node = (void *)cache_noop;
+	else if (sc_lsize == 16)
+		r4k_blast_scache_node = blast_scache16_node;
+	else if (sc_lsize == 32)
+		r4k_blast_scache_node = blast_scache32_node;
+	else if (sc_lsize == 64)
+		r4k_blast_scache_node = blast_scache64_node;
+	else if (sc_lsize == 128)
+		r4k_blast_scache_node = blast_scache128_node;
+}
+
 static inline void local_r4k___flush_cache_all(void * args)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
-	case CPU_LOONGSON3:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -480,6 +497,11 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;
 
+	case CPU_LOONGSON3:
+		/* Use get_ebase_cpunum() for both NUMA=y/n */
+		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
+		break;
+
 	case CPU_BMIPS5000:
 		r4k_blast_scache();
 		__sync();
@@ -840,10 +862,14 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else {
 			blast_scache_range(addr, addr + size);
+		}
 		preempt_enable();
 		__sync();
 		return;
@@ -877,9 +903,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else {
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else {
 			/*
 			 * There is no clearly documented alignment requirement
 			 * for the cache instruction on MIPS processors and
@@ -1918,6 +1947,7 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
 	r4k_blast_dcache_user_page_setup();
 	r4k_blast_icache_user_page_setup();
-- 
2.7.0
