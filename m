Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 07:53:46 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:43301 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007168AbcBBGxjmczZ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2016 07:53:39 +0100
X-QQ-mid: bizesmtp14t1454395982t980t32
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 02 Feb 2016 14:52:10 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: QD5fYv+5332HUXFcZeK32k3jlE6edNVZ9sFjJ8Wau1D8+73WUR32qAIIHtwKL
        830xKCAUXc34W5hTzLmdsUhLP49Jch2RYy7rAhJqkYRQYQrWuERA35dB24x4aYKogu7exqD
        6rwjNifj5WXVJXtjAowthxd6cI7X3BO/zeONKiiftOoa8WzeLMtM62VWjD9nizncL2u0BKC
        vGhWsxvCG62FSMllYa8+D5D7CCC7TO5uvz8DdGaAWbr1ZHMB+ZDNrcjDGCxeH42PqBva/ya
        29Lm36kYYLNWkxBO9PoapfdE0=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 5/6] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Tue,  2 Feb 2016 14:48:43 +0800
Message-Id: <1454395724-28442-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
References: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51620
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

Loongson-3 maintains cache coherency by hardware, this means:
 1) Loongson-3's icache is coherent with dcache.
 2) Loongson-3's dcaches don't alias (if PAGE_SIZE>=16K).
 3) Loongson-3 maintains cache coherency across cores (and for DMA).

So we introduce a cpu feature named cpu_has_coherent_cache and use it
to modify MIPS's cache flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-features.h                |  3 +++
 arch/mips/include/asm/cpu.h                         |  1 +
 .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
 arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e0ba50a..1ec3dea 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -148,6 +148,9 @@
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
index 5f50551..28471f0 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -391,6 +391,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
 #define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
 #define MIPS_CPU_LDPTE		0x100000000000ull /* CPU has ldpte/lddir instructions */
+#define MIPS_CPU_CACHE_COHERENT	0x200000000000ull /* CPU maintains cache coherency by hardware */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index c3406db..647d952 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -46,6 +46,7 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_LOONGSON3)
 #define cpu_hwrena_impl_bits	0xc0000000
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 2abc73d..65fb28c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -429,6 +429,9 @@ static void r4k_blast_scache_setup(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
 	case CPU_LOONGSON3:
@@ -457,6 +460,9 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
 }
 
@@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 {
 	int exec = vma->vm_flags & VM_EXEC;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
@@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 {
 	struct flush_cache_page_args args;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	args.vma = vma;
 	args.addr = addr;
 	args.pfn = pfn;
@@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
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
@@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
-- 
2.4.6
