Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 08:07:09 +0200 (CEST)
Received: from SMTPBG26.QQ.COM ([183.60.2.33]:43521 "EHLO smtpbg26.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008118AbbJGGGtEJprj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Oct 2015 08:06:49 +0200
X-QQ-mid: bizesmtp11t1444197968t832t23
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 07 Oct 2015 14:06:08 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK62
X-QQ-FEAT: zwoLj9LdjHv3m1UbP8c9gyvXA6r5JOeX4WzLbGaPYrks0yOEpKp1MiuW/TsHn
        J9TrKNAxSGxXWR0agZ6kD3W6AV44bexaPjZl7b/cf2ThN0VuOWnfj08XVDEoPYi0abIHZD9
        GgqNTrZxncTbAr+ypYptTN6ICo66+CER4RdLSEme4TSqVucArGEpmNiwogRVzxrKACvxOO+
        7Fe0EJQqcoxYEH5Xd7wWT1aCJqUblbRkVld3SCYdGYIYUjVubaiZbgLs+zoTuBVkdmdjVAS
        hPKZraa7CxjmHy
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V2 3/4] MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature
Date:   Wed,  7 Oct 2015 14:08:01 +0800
Message-Id: <1444198082-24128-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49462
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

Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
feature named cpu_has_coherent_cache and use it to modify MIPS's cache
flushing functions.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/Kconfig                                   |  3 +++
 arch/mips/include/asm/cpu-features.h                |  3 +++
 .../asm/mach-loongson64/cpu-feature-overrides.h     |  1 +
 arch/mips/mm/c-r4k.c                                | 21 +++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9322d26..3a8b7e5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1769,6 +1769,7 @@ config CPU_BMIPS5000
 config SYS_HAS_CPU_LOONGSON3
 	bool
 	select CPU_SUPPORTS_CPUFREQ
+	select CPU_SUPPORTS_COHERENT_CACHE
 
 config SYS_HAS_CPU_LOONGSON2E
 	bool
@@ -1950,6 +1951,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	bool
 config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
+config CPU_SUPPORTS_COHERENT_CACHE
+	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
 	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index d1e04c9..565940e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -157,6 +157,9 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
+#ifndef cpu_has_coherent_cache
+#define cpu_has_coherent_cache	0
+#endif
 #ifndef cpu_has_local_ebase
 #define cpu_has_local_ebase	1
 #endif
diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 98963c2..e0bef38 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -57,5 +57,6 @@
 #define cpu_has_local_ebase	0
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
+#define cpu_has_coherent_cache	IS_ENABLED(CONFIG_CPU_SUPPORTS_COHERENT_CACHE)
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 5d3a25e..ed6e36e 100644
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
@@ -625,6 +634,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 {
 	struct flush_cache_page_args args;
 
+	if (cpu_has_coherent_cache)
+		return;
+
 	args.vma = vma;
 	args.addr = addr;
 	args.pfn = pfn;
@@ -634,11 +646,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 
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
@@ -823,6 +841,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 
 static void r4k_flush_cache_sigtramp(unsigned long addr)
 {
+	if (cpu_has_coherent_cache)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
 }
 
-- 
2.4.6
