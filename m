Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 10:25:45 +0200 (CEST)
Received: from SMTPBG181.QQ.COM ([119.147.193.88]:52177 "EHLO smtpbg181.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993867AbdC2IZjFAENX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Mar 2017 10:25:39 +0200
X-QQ-mid: bizesmtp1t1490775868tx0p56lil
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Mar 2017 16:23:28 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: 9NFkmNiL4hctpXeqK8T5xT4AjVOQh9BsA7aXzelKK6BpVIFzD9vX/1q/sd691
        39SRU3IzNCyn8hKXovbyWnYE4WICYSLv0OWjD0awKaoYtnyYYYIY0vRYCHvgWS6lpYPTwlh
        gBUWX1iKM+w3PveZ28LDVsoFltD8Os+FG7b7tprIWT8HffnKIxS3Oglv9RYjc619cTkNqgX
        QWGWKqW28EL5+s05l/WNXGr5mVCEqtDjuOZigIpIAsBrweRfOVErlM/LIOdzP/0Xog52OfP
        aNIMP1ed+2692twThup6FUqSGYUPyb8t8jPVr189JHdzQG
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V3 2/8] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Wed, 29 Mar 2017 16:24:30 +0800
Message-Id: <1490775876-29918-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
References: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57461
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
(CAC_BASE | (node_id << 44)) instead of CKSEG0 as the start address.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/r4kcache.h | 26 ++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c             | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 55fd94e..000a184 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -747,4 +747,30 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
 __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
 
+#ifdef CONFIG_CPU_LOONGSON3
+#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\
+static inline void blast_##pfx##cache##lsize##_node(long node)		\
+{									\
+	unsigned long start = CAC_BASE | (node << 44);			\
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
+#endif
+
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 3fe99cb..0a49af0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -459,11 +459,29 @@ static void r4k_blast_scache_setup(void)
 		r4k_blast_scache = blast_scache128;
 }
 
+static void (* r4k_blast_scache_node)(long node);
+
+static void r4k_blast_scache_node_setup(void)
+{
+	unsigned long sc_lsize = cpu_scache_line_size();
+
+	r4k_blast_scache_node = (void *)cache_noop;
+#ifdef CONFIG_CPU_LOONGSON3
+	if (sc_lsize == 16)
+		r4k_blast_scache_node = blast_scache16_node;
+	else if (sc_lsize == 32)
+		r4k_blast_scache_node = blast_scache32_node;
+	else if (sc_lsize == 64)
+		r4k_blast_scache_node = blast_scache64_node;
+	else if (sc_lsize == 128)
+		r4k_blast_scache_node = blast_scache128_node;
+#endif
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
@@ -480,6 +498,10 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;
 
+	case CPU_LOONGSON3:
+		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
+		break;
+
 	case CPU_BMIPS5000:
 		r4k_blast_scache();
 		__sync();
@@ -840,7 +862,11 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
+#ifndef CONFIG_CPU_LOONGSON3
 			r4k_blast_scache();
+#else
+			r4k_blast_scache_node((addr >> 44) & 0xF);
+#endif
 		else
 			blast_scache_range(addr, addr + size);
 		preempt_enable();
@@ -873,7 +899,11 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
 		if (size >= scache_size)
+#ifndef CONFIG_CPU_LOONGSON3
 			r4k_blast_scache();
+#else
+			r4k_blast_scache_node((addr >> 44) & 0xF);
+#endif
 		else {
 			/*
 			 * There is no clearly documented alignment requirement
@@ -1903,6 +1933,7 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
 	r4k_blast_dcache_user_page_setup();
 	r4k_blast_icache_user_page_setup();
-- 
2.7.0
