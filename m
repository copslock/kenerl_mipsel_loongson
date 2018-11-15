Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 08:56:19 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:42749
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991082AbeKOHzhTKbs4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 08:55:37 +0100
Received: by mail-pf1-x443.google.com with SMTP id 64so4815170pfr.9;
        Wed, 14 Nov 2018 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1o/kNpFTynfCCO8e3CTgrAzpq+FNajDEU1dHiCL9BM=;
        b=Q6myJgIKnFCFhEhqYSbbAD0lKI/FNAcIo6VWpvHphj2hSDhPk210jRH8LtHAL9fQiE
         mhQdMQoyXLVTVaabdOgixgx2U9miGAwbs1WwuXNa3Y1IXVzWlIZH3vugVL2Gjqlt/1wo
         k9s3Wqwe+ddAtp8QnMUhB4p1RKHXYHW6K+ANTUv8uhmCQXzQujv1R4YJeuz+vw6gb5th
         jM3/4PEoogsl2SXjJyTwOyVBgL1SJ0DgCaDh79WFMfJmmXLZKpoJiIcYrgrbhHy8NcmI
         qgE/0BYXmtUAva//AVb7GjbwGLqkuU8fxIVJGZWgldftAw6H0MjlnAHMWbCu5QUbkcsX
         3ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=P1o/kNpFTynfCCO8e3CTgrAzpq+FNajDEU1dHiCL9BM=;
        b=HP5ZN8XlnwyB0ukYpa7+G9SqC7NEByM1oZopS0lNPJu09u8cc3PNWHcAzmG4IeUvL/
         q0G6XWUfi7lSr0aNY4soSD/3x4UdTrgjIZnV9QbsjC6oucNRuHXuCqrC81Ox1W8lsLMz
         C8TENOVm2Ycw4txvnmKQVuoeOubYRinoJzJMjYs3wbL1uU0edpCLGAOJgVV6OQNEwEXg
         uUxr0+Xv6SVpA29KkJHpy6VsDoK9rXHjdlwE9hoH1t3Wi41n5Qna7rcxtp5+Lex3qPnh
         44MR8J55UkRK6P4q2cx5nmGOhrd79dHqEms7CLh1Ba1hLVvJmUdhYyK6EWoTkuk6fWe2
         Ca5A==
X-Gm-Message-State: AGRZ1gK/xVr36FlQKAjX2Hs8iXZXzp5asOBJxiq/aqp7AY3+J3HBEVW+
        qcVp50/MIAVu6VMgznwHrrFfUpw5vko=
X-Google-Smtp-Source: AJdET5fhvmyqrWmxW4ULfyNxDIGKwWQ9ZX/BVEHV9n3WQ2dQuyaN8ySeRY5EYe48ORVdtbB/o1NZ+Q==
X-Received: by 2002:a63:a552:: with SMTP id r18mr4885983pgu.176.1542268536221;
        Wed, 14 Nov 2018 23:55:36 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k24sm10366286pfj.13.2018.11.14.23.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 23:55:35 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: [PATCH V5 2/8] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Thu, 15 Nov 2018 15:53:53 +0800
Message-Id: <1542268439-4146-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67307
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
index d19b2d6..0815c2a 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -674,4 +674,25 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
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
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws, indexop);	\
+}
+
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
+
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 7e430b4..96d666a 100644
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
