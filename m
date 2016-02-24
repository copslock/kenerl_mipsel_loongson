Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 15:35:05 +0100 (CET)
Received: from smtpbgau1.qq.com ([54.206.16.166]:49215 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012969AbcBXOe442q76 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 15:34:56 +0100
X-QQ-mid: bizesmtp8t1456324463t478t078
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 24 Feb 2016 22:33:49 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 0ESs8nxzjD+Ul1oiKmXriEgj4icUTDBSiSLLHu/vQdAezHQsGz/p3KDPVo4Ep
        S9n7j7BJ/bUtNhi3yOSQp+Sbn/k1Ba3PQ6dPfS3KdrFFkWGwLKGiSdAeW0q+u7JSb9WmtGR
        gHzCAk1C1pMZWZXxfUp3yrv7GM8lvaaJ7TGALj5J/eaF25sjOeyq2cYusY0PUmbhtorB6WJ
        AMs68G6V5wsQUdtXU0BP34J47LAOr8cuph3KEg94E5AO+Zj8hgliVfW9SbwTUktrD3x4rF+
        rjDIz7Gv1J0FMeyOqdB7Grt24ti+CW3OPKZQ==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Introduce cpu_has_coherent_cache feature
Date:   Wed, 24 Feb 2016 22:32:59 +0800
Message-Id: <1456324384-18118-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52194
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

If a platform maintains cache coherency by hardware fully:
 1) It's icache is coherent with dcache.
 2) It's dcaches don't alias (maybe depend on PAGE_SIZE).
 3) It maintains cache coherency across cores (and for DMA).

So we introduce a MIPS_CPU_CACHE_COHERENT bit, and a cpu feature named
cpu_has_coherent_cache to modify MIPS's cache flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-features.h |  3 +++
 arch/mips/include/asm/cpu.h          |  1 +
 arch/mips/mm/c-r4k.c                 | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..0b7f8a5 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -145,6 +145,9 @@
 #ifndef cpu_has_xpa
 #define cpu_has_xpa		(cpu_data[0].options & MIPS_CPU_XPA)
 #endif
+#ifndef cpu_has_coherent_cache
+#define cpu_has_coherent_cache	(cpu_data[0].options & MIPS_CPU_CACHE_COHERENT)
+#endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 7bea0f3..541ba9e 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -390,6 +390,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
 #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
 #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
+#define MIPS_CPU_CACHE_COHERENT	0x100000000000ull /* CPU maintains cache coherency by hardware */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..04a38d8 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -428,6 +428,9 @@ static void r4k_blast_scache_setup(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
 	case CPU_LOONGSON3:
@@ -456,6 +459,9 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
 }
 
@@ -502,6 +508,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 {
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
@@ -626,6 +635,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 {
 	struct flush_cache_page_args args;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	args.vma = vma;
 	args.addr = addr;
 	args.pfn = pfn;
@@ -635,11 +647,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_blast_dcache_page((unsigned long) addr);
 }
 
 static void r4k_flush_data_cache_page(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
@@ -824,6 +842,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
-- 
2.7.0
