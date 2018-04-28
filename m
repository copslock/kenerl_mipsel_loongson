Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:21:57 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:36471
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DVuy19LZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:21:50 +0200
Received: by mail-pg0-x242.google.com with SMTP id i6-v6so2836765pgv.3;
        Fri, 27 Apr 2018 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9DaDkpfjebCYgFETkUFp9tDemjzinGV6fVVsCrymfI=;
        b=C2JK5/qxIDHeo2k68gbQbm+7BCaSj8oOt3oeUwu3eDWXL7Vm5LuFCTqvcUgfrAHTEg
         iszes/vZ0ObYwk9eDnzeiLdGd4bFVWskmUSRMy2AFTgrZEDD82b7qWmWgXGo8bn6Fw/L
         gOqvkk/EZXnJ0XFLU+cSibaxSSKg1U/OoEEfvePLz3PqVrjOpXLwWsFLXoXsMqR7Pbvf
         u+1wVLkgycsznbcYWou/oehK8wS1cwb7vj73if9lULq7DzEl5uUbp4vCLUaWH2Zf2mG/
         Oby1WlK+M7KMvLNHSdKcUFogLj+kBTcMKyxim1PI4X11/tVzmm7CdLLJBlne/xCDlj86
         7agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=W9DaDkpfjebCYgFETkUFp9tDemjzinGV6fVVsCrymfI=;
        b=baJ5C4NpywAOlpLp2JlnGCQOw/ZGYD0RMB4pR5qeclXsGjM198dgvT5Ttzi4BwX+Po
         tLF1uoBMLxDGTqdTcc5fG1UCK5FAzDdT2PBGtzc2aZHzul9RMAPEHgBpE4xWidod2LkF
         n1ulxo1VOorNOLmZ3Ds9nbdnmkDCJj+ooZvjI9PZab92paTfx8B0IjFlObJ6IirAnHaI
         331GWjUCCYUFiDelCC9g4cUlQCQjYonLozlKbiv5EEVreWi2DE7AVcU7fyKFW5yJWIj6
         aFWQc1rXF/nq1hJwpQGr4SGh5IxMFiK9w2iwhRrTMNs+nLfYWrajbbGqJLa4q0Srz13v
         XOZA==
X-Gm-Message-State: ALQs6tDjMZxNgmPfSLWYW1IGOHPDC2UkryioqjkBmieHzVAgLoLY26tB
        mhztiuowu191eyunm2DQic/CAg==
X-Google-Smtp-Source: AB8JxZq6TtF/hMY1FDWnZzRf/FJj7olkNzU6C4aMi11w8qnCw74390pYctuTdLGFU5lRQwgk3EDHNQ==
X-Received: by 2002:a17:902:2f:: with SMTP id 44-v6mr4636930pla.187.1524885704449;
        Fri, 27 Apr 2018 20:21:44 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:21:43 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: [PATCH V3 04/10] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Sat, 28 Apr 2018 11:21:28 +0800
Message-Id: <1524885694-18132-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63822
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
index 6f534b20..2f5abc2 100644
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
@@ -839,10 +861,14 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 
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
@@ -872,9 +898,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 
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
@@ -1905,6 +1934,7 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
 	r4k_blast_dcache_user_page_setup();
 	r4k_blast_icache_user_page_setup();
-- 
2.7.0
